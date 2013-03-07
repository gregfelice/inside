# todo: consider nested attributes

class Milestone < ActiveRecord::Base
  attr_accessible :business_driver, :description, :health, :name, :planned_finish, :planned_start, :status, :facing, :resource_allocations_attributes

  belongs_to :plan
  has_many   :resource_allocations, :dependent => :destroy

  accepts_nested_attributes_for :resource_allocations, allow_destroy: true

  def add_resource_allocation(person, quantity, comment)
    ra = ResourceAllocation.new
    ra.person = person
    ra.quantity = quantity
    ra.comment = comment
    self.resource_allocations << ra
  end

end
