class Employee < ActiveRecord::Base

  attr_accessible :full_name, :job_title, :contractor, :part_time_status, :supervisor_relationships, :subordinate_relationships

  validates_presence_of :full_name, :job_title
  validates_uniqueness_of :full_name

  has_many :supervisor_relationships,     :class_name => "ReportingRelationship",      :foreign_key => :subordinate_id
  has_many :subordinate_relationships,    :class_name => "ReportingRelationship",      :foreign_key => :supervisor_id
  
  # - method name -    
  has_many :supervisors,                  :through => :supervisor_relationships
  has_many :subordinates,                 :through => :subordinate_relationships

end
