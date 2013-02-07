class Employee < ActiveRecord::Base

  validates_presence_of :full_name, :job_title
  validates_uniqueness_of :full_name

  validates_associated :supervisor_relationships, :subordinate_relationships

  after_validation :update_errors

  has_many :supervisor_relationships,  :class_name => "ReportingRelationship", :foreign_key => :subordinate_id, :dependent => :destroy
  has_many :subordinate_relationships, :class_name => "ReportingRelationship", :foreign_key => :supervisor_id,  :dependent => :destroy

  has_many :supervisors, :through => :supervisor_relationships
  has_many :subordinates, :through => :subordinate_relationships

  attr_accessible :full_name, :job_title, :level, :cost_center, :contractor, :part_time_status, :supervisor_relationships, :subordinate_relationships, :direct_subordinate_tokens, :dotted_subordinate_tokens, :direct_supervisor_tokens, :dotted_supervisor_tokens, :direct_supervisors, :dotted_supervisors, :direct_subordinates, :dotted_subordinates

  # update associated error messages, add to self
  def update_errors
    self.supervisor_relationships.reject { |sr| sr.valid? }.each { |sr| sr.errors.messages.each { |key, value| self.errors.add(key, value) } }
    self.subordinate_relationships.reject { |sr| sr.valid? }.each { |sr| sr.errors.messages.each { |key, value| self.errors.add(key, value) } }
  end

  # debugging
  def update_attributes(attributes, options = {})
    logger.info "employee#update_attributes: #{attributes.inspect}"
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
    directs = ids.split(",").flatten.uniq
    dotteds = self.supervisor_relationships.reject { |sr| sr.dotted == false }.collect { |sr| sr.supervisor_id }

    self.supervisor_relationships.clear

    directs.each { |s| self.supervisor_relationships.build(:dotted => false, :supervisor_id => s, :subordinate_id => self.id) }
    dotteds.each { |s| self.supervisor_relationships.build(:dotted => true, :supervisor_id => s, :subordinate_id => self.id) }

    #logger.info "supervisor relationships after direct sup build: #{self.supervisor_relationships.inspect}"


  end

  def dotted_supervisor_tokens
    Employee.dotted_supervisors(self).map { |ds| ds.id }
  end

  def dotted_supervisor_tokens=(ids)

    dotteds = ids.split(",").flatten.uniq
    directs = self.supervisor_relationships.reject { |sr| sr.dotted == true }.collect { |sr| sr.supervisor_id }

    self.supervisor_relationships.clear

    directs.each { |s| self.supervisor_relationships.build(:dotted => false, :supervisor_id => s, :subordinate_id => self.id) }
    dotteds.each { |s| self.supervisor_relationships.build(:dotted => true, :supervisor_id => s, :subordinate_id => self.id) }

  end

  ###############################################################################################################

  def direct_subordinate_tokens
    directs = Employee.direct_subordinates(self).map { |ds| ds.id }
    logger.info "employee#direct_subordinate_tokens: #{directs.inspect}"
    directs
  end

  def direct_subordinate_tokens=(ids)
    directs = ids.split(",").flatten.uniq
    # dotteds = self.dotted_subordinate_tokens
    dotteds = self.subordinate_relationships.reject { |sr| sr.dotted == false }.collect { |sr| sr.subordinate_id }

    logger.info "direct subordinate_tokens=() directs: (directs = ids.split(',').flatten.uniq): #{directs.inspect}"
    logger.info "direct subordinate_tokens=() dotteds: (dotteds = self.dotted_subordinate_tokens): #{dotteds.inspect}"

    self.subordinate_relationships.clear

    directs.each { |s| self.subordinate_relationships.build(:dotted => false, :supervisor_id => self.id, :subordinate_id => s) }
    dotteds.each { |s| self.subordinate_relationships.build(:dotted => true, :supervisor_id => self.id, :subordinate_id => s) }

    logger.info "subordinate relationships after direct sup build: #{self.subordinate_relationships.inspect}"

  end

  def dotted_subordinate_tokens
    dotteds = Employee.dotted_subordinates(self).map { |ds| ds.id }
    logger.info "employee#dotted_subordinate_tokens: #{dotteds.inspect}"
    dotteds
  end

  def dotted_subordinate_tokens=(ids)

    dotteds = ids.split(",").flatten.uniq
    directs = self.subordinate_relationships.reject { |sr| sr.dotted == true }.collect { |sr| sr.subordinate_id }

    logger.info "dotted subordinate_tokens=() directs: (directs = self.direct_subordinate_tokens): #{directs.inspect}"
    logger.info "dotted subordinate_tokens=() dotteds: (dotteds = ids.split(',').flatten.uniq): #{dotteds.inspect}"

    logger.info "subordinate relationships after dotted sup build, before clear: #{self.subordinate_relationships.inspect}"
    self.subordinate_relationships.clear
    logger.info "subordinate relationships after dotted sup build, after clear: #{self.subordinate_relationships.inspect}"

    directs.each { |s| self.subordinate_relationships.build(:dotted => false, :supervisor_id => self.id, :subordinate_id => s) }
    dotteds.each { |s| self.subordinate_relationships.build(:dotted => true, :supervisor_id => self.id, :subordinate_id => s) }

    logger.info "subordinate relationships after dotted sup build: #{self.subordinate_relationships.inspect}"

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

end
