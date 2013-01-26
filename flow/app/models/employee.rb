class Employee < ActiveRecord::Base

  validates_presence_of :full_name, :job_title
  validates_uniqueness_of :full_name

  has_many :supervisor_relationships,     :class_name => "ReportingRelationship",      :foreign_key => :subordinate_id
  has_many :subordinate_relationships,    :class_name => "ReportingRelationship",      :foreign_key => :supervisor_id

  has_many :supervisors,                  :through => :supervisor_relationships
  has_many :subordinates,                 :through => :subordinate_relationships

  attr_accessible :full_name, :job_title, :level, :cost_center, :contractor, :part_time_status, :supervisor_relationships, :subordinate_relationships, :subordinate_tokens, :supervisor_tokens, :dotted_supervisors, :dotted_supervisor_tokens, :direct_supervisor_tokens

  def dotted_supervisors
    self.class.dotted_supervisors(self)
  end

  def direct_supervisors
    self.class.direct_supervisors(self)
  end

  # jquery-token-input related
  ###############################################################################################################

  attr_reader :supervisor_tokens

  def supervisor_tokens=(ids) 
    self.supervisor_ids = ids.split(",").uniq # ensure unique values
  end

  ###############################################################################################################
  
  def dotted_supervisor_tokens
    Employee.dotted_supervisors(self).map { |ds| ds.id }
  end

  def dotted_supervisor_tokens=(ids) 
    dotteds = ids.split(",").flatten.uniq
    directs = self.direct_supervisor_tokens
    
    self.supervisor_relationships.clear

    directs.each { |s| self.supervisor_relationships.build(:dotted => false, :supervisor_id => s, :subordinate_id => self.id) }
    dotteds.each { |s| self.supervisor_relationships.build(:dotted => true, :supervisor_id => s, :subordinate_id => self.id) }

    self.save
  end

  ###############################################################################################################

  def direct_supervisor_tokens
    Employee.direct_supervisors(self).map { |ds| ds.id }
  end
  
  def direct_supervisor_tokens=(ids) 
    directs = ids.split(",").flatten.uniq
    dotteds = self.dotted_supervisor_tokens
    
    self.supervisor_relationships.clear
    
    directs.each { |s| self.supervisor_relationships.build(:dotted => false, :supervisor_id => s, :subordinate_id => self.id) }
    dotteds.each { |s| self.supervisor_relationships.build(:dotted => true, :supervisor_id => s, :subordinate_id => self.id) }

    self.save
  end

  ###############################################################################################################

  attr_reader :subordinate_tokens

  def subordinate_tokens=(ids)
    self.subordinate_ids = ids.split(",").flatten.uniq # ensure unique values
  end

  ###############################################################################################################

 
  # all of my supervisors with a dotted relationship
  scope :dotted_supervisors, lambda { |employee| employee.supervisor_relationships.where(:dotted => true).map { |ds| ds.supervisor } }

  # all of my supervisors direct relationship
  scope :direct_supervisors, lambda { |employee| employee.supervisor_relationships.where("dotted is null OR dotted = false").map { |ds| ds.supervisor } }

  # give me all employees that are not currently me, or currently my subordinate
  # (not used since show.erb.html changes)
  scope :eligible_subordinates, lambda { |employee| where("id != ?", employee.id).where("id NOT IN (?)", employee.subordinates.size == 0 ? 0 : employee.subordinates).order("full_name") }

  # give me all employees that are not currently me, or currently my supervisor
  scope :eligible_supervisors, lambda { |employee| where("id != ?", employee.id).where("id NOT IN (?)", employee.supervisors.size == 0 ? 0 : employee.supervisors).order("full_name") }

end
