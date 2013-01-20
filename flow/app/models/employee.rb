class Employee < ActiveRecord::Base

  attr_accessible :full_name, :job_title, :level, :cost_center, :contractor, :part_time_status, :supervisor_relationships, :subordinate_relationships

  validates_presence_of :full_name, :job_title
  validates_uniqueness_of :full_name

  has_many :supervisor_relationships,     :class_name => "ReportingRelationship",      :foreign_key => :subordinate_id
  has_many :subordinate_relationships,    :class_name => "ReportingRelationship",      :foreign_key => :supervisor_id
  
  # collection accessor name (seems as if it's not needed in the attr_accessible section)
  has_many :supervisors,                  :through => :supervisor_relationships
  has_many :subordinates,                 :through => :subordinate_relationships
  
  # support for modal search screens. note that if the param 'search' does not exist, then we just return the whole thing.
  def self.search(search)
    if search
      find(:all, :conditions => ['full_name LIKE ?', "%#{search}%"], :order => "full_name")
    else
      find(:all, :order => "full_name")
    end
  end

end
