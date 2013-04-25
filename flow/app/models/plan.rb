class Plan < ActiveRecord::Base

  attr_accessible :description, :name, :portfolio_category, :milestones_attributes, :resource_allocations_attributes

  belongs_to :portfolio
  has_many :milestones

  accepts_nested_attributes_for :milestones, allow_destroy: true

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
