# todo: consider nested attributes

class Milestone < ActiveRecord::Base
  attr_accessible :business_driver, :description, :health, :name, :planned_finish, :planned_start, :status, :facing

  belongs_to :plan
  has_many   :resource_allocations, :dependent => :destroy

  def add_resource_allocation(person, quantity, comment)
    ra = ResourceAllocation.new
    ra.person = person
    ra.quantity = quantity
    ra.comment = comment
    self.resource_allocations << ra
  end

end
