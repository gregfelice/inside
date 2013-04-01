class Portfolio < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :plans

end
