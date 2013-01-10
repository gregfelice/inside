class Employee < ActiveRecord::Base

  attr_accessible :contractor, :full_name, :job_title, :part_time_status, :reporting_relationship_attributes
  
  has_many :reporting_relationships
  has_many :employees, :through => :reporting_relationships, :uniq => true

  validates :full_name, :job_title, :presence => true

  validates :full_name, :uniqueness => true

  accepts_nested_attributes_for :reporting_relationships

end
