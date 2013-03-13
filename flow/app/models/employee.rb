class Employee < ActiveRecord::Base
  include DirtyAssociations

  attr_accessible :full_name, :job_title, :level, :cost_center, :contractor, :part_time_status, :supervisor_relationships, :subordinate_relationships, :direct_subordinate_tokens, :dotted_subordinate_tokens, :direct_supervisor_tokens, :dotted_supervisor_tokens, :direct_supervisors, :dotted_supervisors, :direct_subordinates, :dotted_subordinates, :org_context

  validates_presence_of :full_name, :job_title
  validates_uniqueness_of :full_name

  validates_associated :supervisor_relationships, :subordinate_relationships

  after_validation :update_errors

  has_many :supervisor_relationships,  :class_name => "ReportingRelationship", :foreign_key => :subordinate_id, :dependent => :destroy, :after_add => :make_dirty, :after_remove => :make_dirty
  has_many :subordinate_relationships, :class_name => "ReportingRelationship", :foreign_key => :supervisor_id,  :dependent => :destroy, :after_add => :make_dirty, :after_remove => :make_dirty

  has_many :supervisors, :through => :supervisor_relationships, :after_add => :make_dirty, :after_remove => :make_dirty
  has_many :subordinates, :through => :subordinate_relationships, :after_add => :make_dirty, :after_remove => :make_dirty

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

  def org_context
    ReportingRelationshipsTree.instance.get_direct_reporting_relationships_tree(self)
  end

  # update associated error messages, add to self
  def update_errors
    self.supervisor_relationships.reject { |sr| sr.valid? }.each { |sr| sr.errors.messages.each { |key, value| self.errors.add(key, value) } }
    self.subordinate_relationships.reject { |sr| sr.valid? }.each { |sr| sr.errors.messages.each { |key, value| self.errors.add(key, value) } }
  end

  # select the direct reporting relationships and all associated employee information needed to construct tree
  def self.join_employees_by_relationship_type

    sql = <<EOF
select supers.id, supers.full_name, subs.id, subs.full_name
from reporting_relationships rr
inner join employees as supers
  on supers.id = rr.supervisor_id
inner join employees as subs
  on subs.id = rr.subordinate_id
and dotted = false
order by supers.id
EOF

    r = ActiveRecord::Base.connection.execute(sql)
  end

  # place SQL results into a hashkeyed off of supervisor ids, pointing to a list of subordinates for that supervisor
  def self.build_adjacency_list

    r = Employee.join_employees_by_relationship_type

    h = {}
    r.each {|rr|
      id = rr[0]
      h[id] = {:id => id, :name => rr[1], :children => []} if h[id].nil?   # if there's no hash entry for this employee, make one.
      h[id][:children] << {:id => rr[2], :name => rr[3], :children => []}  # enter the employee's subordinates as children into the hash. (source / sink)
    }
    h
  end

end

=begin

  # build an adjacnecy list with JUST the ids.
  def self.build_adjacency_list_ids(relationship_type)

    r = self.class.join_employees_by_relationship_type(relationship_type)
    h = {}
    r.each {|rr|
      id = rr[0]
      h[id] = [] if h[id].nil?
      h[id] << rr[2]
    }
    h
  end

  # takes output of build_adjacency_list_ids
  def self.get_graph_cycles(h)
    scc = []
    ts = h.strongly_connected_components
    ts.each {|s| scc << s if s.size > 1}
    scc
  end

=end

# used for tsorts
=begin
class Hash
  include TSort
  alias tsort_each_node each_key
  def tsort_each_child(node, &block)
    fetch(node).each(&block) if self.has_key?(node)
  end
end
=end
