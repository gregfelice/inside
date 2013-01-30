class ReportingRelationship < ActiveRecord::Base
  
  attr_accessible :dotted, :subordinate_id, :supervisor_id, :supervisor, :subordinate
  
  belongs_to :supervisor,   :class_name => "Employee"
  belongs_to :subordinate,  :class_name => "Employee"

  validates :dotted, :inclusion => { :in => [true, false] }
  validates_uniqueness_of :subordinate_id, :scope => [:supervisor_id]
  
  validate :noncircular_relationship

  def noncircular_relationship 
    errors.add(:supervisor_id, "Invalid circular relationship.") if supervisor_id == subordinate_id
  end
  
end
