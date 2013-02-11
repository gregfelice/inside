class Employee < ActiveRecord::Base
  include DirtyAssociations

  attr_accessible :full_name, :job_title, :level, :cost_center, :contractor, :part_time_status, :supervisor_relationships, :subordinate_relationships, :direct_subordinate_tokens, :dotted_subordinate_tokens, :direct_supervisor_tokens, :dotted_supervisor_tokens, :direct_supervisors, :dotted_supervisors, :direct_subordinates, :dotted_subordinates, :org_context

  validates_presence_of :full_name, :job_title
  validates_uniqueness_of :full_name

  validates_associated :supervisor_relationships, :subordinate_relationships

  after_update :update_cache
  after_validation :update_errors

  has_many :supervisor_relationships,  :class_name => "ReportingRelationship", :foreign_key => :subordinate_id, :dependent => :destroy, :after_add => :make_dirty, :after_remove => :make_dirty
  has_many :subordinate_relationships, :class_name => "ReportingRelationship", :foreign_key => :supervisor_id,  :dependent => :destroy, :after_add => :make_dirty, :after_remove => :make_dirty

  has_many :supervisors, :through => :supervisor_relationships
  has_many :subordinates, :through => :subordinate_relationships


  # debugging
  def update_attributes(attributes, options = {})
    # logger.info "employee#update_attributes: #{attributes.inspect}"
    super(attributes, options)
  end

  # convenience method, assumes dotted == false
  def add_supervisor(supervisor)
    self.supervisor_relationships.create!( { :dotted => false, :supervisor_id => supervisor.id, :subordinate_id => self.id } )
  end

  # convenience method, assumes dotted == false
  def add_subordinate(subordinate)
    self.subordinate_relationships.create!( { :dotted => false, :supervisor_id => self.id, :subordinate_id => subordinate.id } )
  end

  def direct_supervisors
    self.class.direct_supervisors(self)
  end

  def dotted_supervisors
    self.class.dotted_supervisors(self)
  end

  def direct_subordinates
    self.class.direct_subordinates(self)
  end

  def dotted_subordinates
    self.class.dotted_subordinates(self)
  end

  # jquery-token-input related

  def direct_supervisor_tokens
    Employee.direct_supervisors(self).map { |ds| ds.id }
  end

  def direct_supervisor_tokens=(ids)
    returned_ids = ids.split(",").flatten.uniq.collect{ |s| s.to_i }
    current_ids  = self.direct_supervisors.collect { |s| s.id }

    logger.info "dirty? #{self.changed?}"
    to_be_added = returned_ids - current_ids
    to_be_removed = current_ids - returned_ids

    to_be_added.each { |s| self.supervisor_relationships.build(:dotted => false, :supervisor_id => s, :subordinate_id => self.id) }
    to_be_removed.each {|s| self.supervisors.delete( self.class.where(:id => s)) }
  end

  def dotted_supervisor_tokens
    Employee.dotted_supervisors(self).map { |ds| ds.id }
  end

  def dotted_supervisor_tokens=(ids)
    returned_ids = ids.split(",").flatten.uniq.collect{ |s| s.to_i }
    current_ids  = self.dotted_supervisors.collect { |s| s.id }

    to_be_added = returned_ids - current_ids
    to_be_removed = current_ids - returned_ids

    to_be_added.each { |s| self.supervisor_relationships.build(:dotted => true, :supervisor_id => s, :subordinate_id => self.id) }
    to_be_removed.each {|s| self.supervisors.delete( self.class.where(:id => s)) }
  end

  ###############################################################################################################

  def direct_subordinate_tokens
    directs = Employee.direct_subordinates(self).map { |ds| ds.id }
    # logger.info "employee#direct_subordinate_tokens: #{directs.inspect}"
    directs
  end

  def direct_subordinate_tokens=(ids)
    returned_ids = ids.split(",").flatten.uniq.collect{ |s| s.to_i }
    current_ids  = self.direct_subordinates.collect { |s| s.id }

    to_be_added = returned_ids - current_ids
    to_be_removed = current_ids - returned_ids

    to_be_added.each { |s| self.subordinate_relationships.build(:dotted => false, :supervisor_id => self.id, :subordinate_id => s) }
    to_be_removed.each {|s| self.subordinates.delete( self.class.where(:id => s)) }
  end

  def dotted_subordinate_tokens
    dotteds = Employee.dotted_subordinates(self).map { |ds| ds.id }
    # logger.info "employee#dotted_subordinate_tokens: #{dotteds.inspect}"
    dotteds
  end

  def dotted_subordinate_tokens=(ids)
    returned_ids = ids.split(",").flatten.uniq.collect{ |s| s.to_i }
    current_ids  = self.dotted_subordinates.collect { |s| s.id }

    to_be_added = returned_ids - current_ids
    to_be_removed = current_ids - returned_ids

    to_be_added.each { |s| self.subordinate_relationships.build(:dotted => true, :supervisor_id => self.id, :subordinate_id => s) }
    to_be_removed.each {|s| self.subordinates.delete( self.class.where(:id => s)) }
  end

  ###############################################################################################################

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |employee|
        csv << employee.attributes.values_at(*column_names)
      end
    end
  end

  # all of my supervisors with a dotted relationship
  scope :dotted_supervisors, lambda { |employee| employee.supervisor_relationships.where(:dotted => true).map { |ds| ds.supervisor } }

  # all of my supervisors direct relationship
  scope :direct_supervisors, lambda { |employee| employee.supervisor_relationships.where(:dotted => false).map { |ds| ds.supervisor } }


  # all of my subordinates with a dotted relationship
  scope :dotted_subordinates, lambda { |employee| employee.subordinate_relationships.where(:dotted => true).map { |ds| ds.subordinate } }

  # all of my subordinates direct relationship
  scope :direct_subordinates, lambda { |employee| employee.subordinate_relationships.where(:dotted => false).map { |ds| ds.subordinate } }


  # give me all employees that are not currently me, or currently my subordinate
  # (not used since show.erb.html changes)
  scope :eligible_subordinates, lambda { |employee| where("id != ?", employee.id).where("id NOT IN (?)", employee.subordinates.size == 0 ? 0 : employee.subordinates).order("full_name") }

  # give me all employees that are not currently me, or currently my supervisor
  scope :eligible_supervisors, lambda { |employee| where("id != ?", employee.id).where("id NOT IN (?)", employee.supervisors.size == 0 ? 0 : employee.supervisors).order("full_name") }

  # returns json tree from my direct supervisor, down
  def org_context
    get_tree
  end

  private

  # update associated error messages, add to self
  def update_errors
    self.supervisor_relationships.reject { |sr| sr.valid? }.each { |sr| sr.errors.messages.each { |key, value| self.errors.add(key, value) } }
    self.subordinate_relationships.reject { |sr| sr.valid? }.each { |sr| sr.errors.messages.each { |key, value| self.errors.add(key, value) } }
  end

  # https://devcenter.heroku.com/articles/caching-strategies
  # http://api.rubyonrails.org/classes/ActiveSupport/Cache/Store.html#method-i-fetch
  def get_tree
    # ttl sucks. ok - the first person to hit this will still see the lag. not workable
    # need another solution: ? -> http://kovyrin.net/2008/03/10/dog-pile-effect-and-how-to-avoid-it-with-ruby-on-rails-memcache-client-patch/
    # problem here is we explicitly invalidate the cache, want to rebuild it upon update, and have it take place of the value, later...
    tree = Rails.cache.fetch(:tree, :expires_in => 30.seconds, :race_condition_ttl => 120) do
      tree = rebuild_tree
    end
    # logger.info "tree built: #{tree}"
    # then, recurse to find the node i want to start with
    node = find_by_id(tree, get_tree_top_id)
    node
  end

  def rebuild_tree
    logger.info "in rebuilding tree."
    tt = self.class.find_by_id(360)
    logger.info "building with #{tt.inspect}"
    tn = to_node tt, 0  # arthur
    # logger.info "returning new tree: #{tn}"
    tn
  end

  def find_by_id(node, find_this="")
    logger.info "searching for #{find_this} in tree...."
    if node.is_a?(Hash)
      node.each do |k,v|
        if v.is_a?(Array)
          v.each do |elm|
            if elm["id"] == find_this
              return elm      # THIS IS WHAT I WANT!
            else
              result = find_by_id(elm, find_this)
              return result if result
            end
          end
        end
      end
    end
    nil
  end

  # if i have no supervisor, return me
  def get_tree_top_id
    if self.supervisor_relationships.empty?
      self.id
    else
      sup = self.supervisor_relationships.reject{|sr| sr.dotted == true}.first
      sup.supervisor_id
    end
  end

  # look into: http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
  def to_node(n, i)
    #i = i + 1
    #logger.info "#{n.full_name} #{i}"
    #logger.info "direct subs: #{n.direct_subordinates}"
    {
      "id" => n.id,
      "name" => n.full_name,
      "size" => 1,
      "children" => n.direct_subordinates.empty? ? "" : n.direct_subordinates.map { |c| to_node c, i }
    }
  end

  # update the json reporting hierarchy for self
  # http://blog.plataformatec.com.br/2009/09/how-to-avoid-dog-pile-effect-rails-app/
  def update_cache
    if self.changed?
      logger.info "self.changed. self: #{self.inspect}"
      Thread.new do
        logger.info "rebuilding tree in thread."
        tree = rebuild_tree
        logger.info "done rebuilding tree. writing tree to cache."
        Rails.cache.write(:tree, tree) # replace stale tree with new tree.
        logger.info "tree written to cache."
      end
    end
  end

end
