ActiveAdmin.register Employee do

  index do 
    column :full_name
    column :job_title
    column "Supervisor", :supervisor do |employee|
      begin # todo better nil check
        employee.reporting_relationships.first.supervisor.full_name
        # employee.reporting_relationships.first.supervisor.full_name
      rescue
        "None"
      end
    end
    column :contractor
    column :part_time_status
    default_actions
  end

end
