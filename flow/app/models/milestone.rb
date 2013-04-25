# todo: consider nested attributes

class Milestone < ActiveRecord::Base
  attr_accessible :business_driver, :description, :health, :name, :planned_finish, :planned_start, :status, :facing

  belongs_to :plan

end
