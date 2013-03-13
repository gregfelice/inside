=begin

todos

excel export
front end token support
refactor and extraction of faster tree creation
refactor and extraction of cycle detection into service object
refactor of subordinate association validation error percolation
rules around person type, validation (hold off on creating lookup db tables for types, keep in code for now)

=end
class Person < ActiveRecord::Base
  include DirtyAssociations

  attr_accessible :id, :name, :title, :person_type

  validates_presence_of :name, :title

  has_many :source_associations,    :class_name => "PersonAssociation",  :foreign_key => :sink_id,        :dependent => :destroy,      :after_add => :make_dirty, :after_remove => :make_dirty
  has_many :sink_associations,      :class_name => "PersonAssociation",  :foreign_key => :source_id,      :dependent => :destroy,      :after_add => :make_dirty, :after_remove => :make_dirty

  has_many :resource_allocations, :dependent => :destroy

  public

  def initialize(attributes={})
    super
    @person_type ||= 'employee'
  end

  # direct supervisor accessors
  def add_direct_supervisor(person); self.source_associations.build( { :person_type => PersonAssociation.types(:direct_reporting), :source_id => person.id, :sink_id => self.id } ); end
  scope :direct_supervisors, lambda { |person| person.source_associations.where(:person_type => PersonAssociation.types(:direct_reporting) ).map { |ds| ds.source } }
  def direct_supervisors; self.class.direct_supervisors(self); end

  # dotted supervisor accesors
  def add_dotted_supervisor(person); self.source_associations.build( { :person_type => PersonAssociation.types(:dotted_reporting), :source_id => person.id, :sink_id => self.id } ); end
  scope :dotted_supervisors, lambda { |person| person.source_associations.where(:person_type => PersonAssociation.types(:dotted_reporting) ).map { |ds| ds.source } }
  def dotted_supervisors; self.class.dotted_supervisors(self); end

  # direct subordinate accessors
  def add_direct_subordinate(person); self.sink_associations.build( { :person_type => PersonAssociation.types(:direct_reporting), :source_id => self.id, :sink_id => person.id } ); end
  scope :direct_subordinates, lambda { |person| person.sink_associations.where(:person_type => PersonAssociation.types(:direct_reporting) ).map { |ds| ds.source } }
  def direct_subordinates; self.class.direct_subordinates(self); end

  # dotted subordinate accessors
  def add_dotted_subordinate(person); self.sink_associations.build( { :person_type => PersonAssociation.types(:dotted_reporting), :source_id => self.id, :sink_id => person.id } ); end
  scope :dotted_subordinates, lambda { |person| person.sink_associations.where(:person_type => PersonAssociation.types(:dotted_reporting) ).map { |ds| ds.source } }
  def dotted_subordinates; self.class.dotted_subordinates(self); end

  private

  # foo




end
