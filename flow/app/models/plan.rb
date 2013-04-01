class Plan < ActiveRecord::Base

  attr_accessible :description, :name, :portfolio_category, :milestones_attributes

  belongs_to :portfolio
  has_many :milestones

  accepts_nested_attributes_for :milestones, allow_destroy: true

end
