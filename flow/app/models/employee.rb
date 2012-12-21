class Employee < ActiveRecord::Base

  attr_accessible :contractor, :full_name, :job_title, :part_time_status
  
  has_many :reporting_relationships
  has_many :employees, :through => :reporting_relationships, :uniq => true

  validates_uniqueness_of :full_name
end
