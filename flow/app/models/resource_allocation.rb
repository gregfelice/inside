class ResourceAllocation < ActiveRecord::Base

  attr_accessible :comment, :quantity, :plan_id, :person_id, :resource_name

  belongs_to :plan
  belongs_to :person, :inverse_of => :resource_allocations

  validates_uniqueness_of :person_id, :scope => [:milestone_id]

  public

  def resource_name
    person.try(:name)
  end

  def resource_name=(name)
    self.person = Person.find_by_name(name) if name.present?
  end

end
