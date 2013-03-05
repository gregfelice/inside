class Plan < ActiveRecord::Base

  attr_accessible :description, :name, :portfolio_category

  belongs_to :portfolio
  has_many :milestones

end
