class Person < ActiveRecord::Base
  include DirtyAssociations

  @person_types = ['employee', 'contractor']
  @hr_statuses = ['active', 'resigned']
  @hiring_statuses = ['requested', 'approved / not posted', 'approved / posted', 'unbudgeted / posted', 'hired']
  @budgets = ['Digital', 'Digital IITT', 'Digital PP2', 'S&T CES']
  @location_floors = [
    '7 North', '7 South', '7 East', '7 West', '8 North', '8 South', '8 East', '8 West', '9 North', '9 South', '9 East', '9 West', '10 North', '10 South', '10 East', '10 West',
    '11 North', '11 South', '11 East', '11 West', '12 North', '12 South', '12 East', '12 West', '13 North', '13 South', '13 East', '13 West'
  ]
  @person_roles = ['Software Engineer', 'Systems Engineer', 'Quality Assurance', 'Project Management', 'Other']
  @person_foci = ['Information Worker', 'People Management', 'Other']

  @groups = [
    'Ad Ops',
    'Business Development',
    'Business Intelligence',
    'CMS',
    'Digital Paid Products',
    'Ecommerce & Customer Service',
    'Ecommerce UI Engineering',
    'Emerging Technologies',
    'Finance',
    'Infrastructure Engineering',
    'New Products',
    'Planning',
    'Platform Technologies',
    'Project Management',
    'Quality Assurance',
    'Technology Management',
    'Web & Mobile Engineering',
    'Web Technologies'
  ]

  @seatings = ['offsite', 'hotel', 'hotel w/home', 'home']

  class << self
    attr_accessor :person_types, :hr_statuses, :hiring_statuses, :budgets, :groups, :seatings, :location_floors, :person_roles, :person_foci
  end

  attr_accessible :id, :name, :title, :person_type, :temporary, :hr_status, :part_time, :cost_center, :business_unit, :direct_subordinate_tokens, :dotted_subordinate_tokens, :direct_supervisor_tokens, :dotted_supervisor_tokens, :location_floor, :location_code, :hiring_status, :seating, :employment_start_date, :employment_end_date, :budget, :group, :office_phone, :cell_phone, :person_role, :person_focus

  validates_presence_of :name, :title, :person_type

  validates :person_type,   :inclusion => { :in => @person_types,        :message => "%{value} is not a valid person type" }
  #validates :hr_status,     :inclusion => { :in => @hr_statuses,         :message => "%{value} is not a valid HR status" }
  #validates :hiring_status, :inclusion => { :in => @hiring_statuses,     :message => "%{value} is not a valid hiring status" }

  #validates :budget,        :inclusion => { :in => @budgets,             :message => "%{value} is not a valid budget" }
  #validates :group,         :inclusion => { :in => @groups,              :message => "%{value} is not a valid group" }
  #validates :seating,       :inclusion => { :in => @seatings,            :message => "%{value} is not a valid seating" }

  validates :part_time,     :inclusion => { :in => [true, false] }
  validates :temporary,     :inclusion => { :in => [true, false] }

  before_validation :checks

  has_many :source_associations, :class_name => "PersonAssociation",  :foreign_key => :sink_id,    :dependent => :destroy,  :after_add => :make_dirty, :after_remove => :make_dirty
  has_many :sink_associations,   :class_name => "PersonAssociation",  :foreign_key => :source_id,  :dependent => :destroy,  :after_add => :make_dirty, :after_remove => :make_dirty

  has_many :resource_allocations, :dependent => :destroy

  has_many :sources, :through => :source_associations, :after_add => :make_dirty, :after_remove => :make_dirty
  has_many :sinks,   :through => :sink_associations,   :after_add => :make_dirty, :after_remove => :make_dirty

  #def initialize(attributes={})
  #  super
  #  @person_type   ||= :employee
  #  @hr_status     ||= :active
  #  logger.info "initialize values: #{self.inspect}"
  #end

  ################################################################################################
  # start custom validations, update hooks
  #
  def checks
    #logger.info "checks"
    #logger.info self.person_type
    #logger.info self.person_type.class
  end

  validate :miscellaneous_rules
  def miscellaneous_rules
    # todo -- add complex inter-field rules here
    # errors.add(:expiration_date, "can't be in the past")
  end

  before_save :adjust_attributes
  def adjust_attributes
    # in the event that some fields must change based upon other values, set here..
  end
  #
  # end custom validations, update hooks
  ################################################################################################

  #
  # csv export support
  #
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |person|
        csv << person.attributes.values_at(*column_names)
      end
    end
  end

  # direct supervisor accessors
  def add_direct_supervisor(person); self.source_associations.build( { :association_type => 'direct_reporting', :source_id => person.id, :sink_id => self.id } ); end
  scope :direct_supervisors, lambda { |person| person.source_associations.where(:association_type => :direct_reporting).map { |ds| ds.source } }
  def direct_supervisors; self.class.direct_supervisors(self); end

  # dotted supervisor accesors
  def add_dotted_supervisor(person); self.source_associations.build( { :association_type => 'dotted_reporting', :source_id => person.id, :sink_id => self.id } ); end
  scope :dotted_supervisors, lambda { |person| person.source_associations.where(:association_type => :dotted_reporting).map { |ds| ds.source } }
  def dotted_supervisors; self.class.dotted_supervisors(self); end

  # direct subordinate accessors
  def add_direct_subordinate(person); self.sink_associations.build( { :association_type => 'direct_reporting', :source_id => self.id, :sink_id => person.id } ); end
  scope :direct_subordinates, lambda { |person| person.sink_associations.where(:association_type => :direct_reporting).map { |ds| ds.sink } }
  def direct_subordinates; self.sink_associations.where(:association_type => :direct_reporting).map { |ds| ds.sink }; end

  # dotted subordinate accessors
  def add_dotted_subordinate(person); self.sink_associations.build( { :association_type => 'dotted_reporting', :source_id => self.id, :sink_id => person.id } ); end
  scope :dotted_subordinates, lambda { |person| person.sink_associations.where(:association_type => :dotted_reporting).map { |ds| ds.sink } }
  def dotted_subordinates; self.class.dotted_subordinates(self); end

  # jquery-token-input related

  def direct_supervisor_tokens
    Person.direct_supervisors(self).map { |ds| ds.id }
  end

  def direct_supervisor_tokens=(ids)
    returned_ids = ids.split(",").flatten.uniq.collect{ |s| s.to_i }
    current_ids  = self.direct_supervisors.collect { |s| s.id }
    to_be_added = returned_ids - current_ids
    to_be_removed = current_ids - returned_ids
    to_be_added.each { |s| self.source_associations.build(:association_type => 'direct_reporting', :source_id => s, :sink_id => self.id) }
    to_be_removed.each {|s| self.sources.delete( self.class.where(:id => s)) }
  end

  def dotted_supervisor_tokens
    Person.dotted_supervisors(self).map { |ds| ds.id }
  end

  def dotted_supervisor_tokens=(ids)
    returned_ids = ids.split(",").flatten.uniq.collect{ |s| s.to_i }
    current_ids  = self.dotted_supervisors.collect { |s| s.id }
    to_be_added = returned_ids - current_ids
    to_be_removed = current_ids - returned_ids
    to_be_added.each { |s| self.source_associations.build(:association_type => 'dotted_reporting', :source_id => s, :sink_id => self.id) }
    to_be_removed.each {|s| self.sources.delete( self.class.where(:id => s)) }
  end

  def direct_subordinate_tokens
    Person.direct_subordinates(self).map { |ds| ds.id }
  end

  def direct_subordinate_tokens=(ids)
    returned_ids = ids.split(",").flatten.uniq.collect{ |s| s.to_i }
    current_ids  = self.direct_subordinates.collect { |s| s.id }
    to_be_added = returned_ids - current_ids
    to_be_removed = current_ids - returned_ids
    to_be_added.each { |s| self.sink_associations.build(:association_type => 'direct_reporting', :source_id => self.id, :sink_id => s) }
    to_be_removed.each {|s| self.sinks.delete( self.class.where(:id => s)) }
  end

  def dotted_subordinate_tokens
    Person.dotted_subordinates(self).map { |ds| ds.id }
  end

  def dotted_subordinate_tokens=(ids)
    returned_ids = ids.split(",").flatten.uniq.collect{ |s| s.to_i }
    current_ids  = self.dotted_subordinates.collect { |s| s.id }
    to_be_added = returned_ids - current_ids
    to_be_removed = current_ids - returned_ids
    to_be_added.each { |s| self.sink_associations.build(:association_type => 'dotted_reporting', :source_id => self.id, :sink_id => s) }
    to_be_removed.each {|s| self.sinks.delete( self.class.where(:id => s)) }
  end



end
