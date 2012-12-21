class ReportingRelationship < ActiveRecord::Base

  attr_accessible :dotted, :employee_id, :supervisor_id, :supervisor, :employee

  belongs_to :employee
  belongs_to :supervisor, :class_name => "Employee"

  validates_uniqueness_of :employee_id, :scope => [:supervisor_id]

end
