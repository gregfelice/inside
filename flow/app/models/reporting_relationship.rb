class ReportingRelationship < ActiveRecord::Base

  attr_accessible :dotted, :subordinate_id, :supervisor_id, :supervisor, :subordinate

  belongs_to :supervisor,   :class_name => "Employee"
  belongs_to :subordinate,  :class_name => "Employee"

  validates :dotted, :inclusion => { :in => [true, false] }
  validates_uniqueness_of :subordinate_id, :scope => [:supervisor_id]
end
