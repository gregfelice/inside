ActiveAdmin.register ReportingRelationship do

  index do
    column "Supervisor", :supervisor do |reporting_relationship|
      begin
        reporting_relationship.supervisor.full_name
      rescue
        "None"
      end
    end
    column "Employee", :employee do |reporting_relationship|
      begin
        reporting_relationship.employee.full_name
      rescue
        "None"
      end
    end
    column :dotted
    
  end
  
end
