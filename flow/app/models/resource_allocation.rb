class ResourceAllocation < ActiveRecord::Base
  attr_accessible :comment, :quantity

  belongs_to :milestone
  belongs_to :person, :inverse_of => :resource_allocations

  validates_uniqueness_of :person_id, :scope => [:milestone_id]

end
