class EmployeesController < InheritedResources::Base

  # GET /employees/1
  # GET /employees/1.json
  def show
    @employee = Employee.find(params[:id])
    
    # get my supervisor
    #

    # get a list of reports
    @reports = []
    ReportingRelationship.where("supervisor_id =?", params[:id]).each {|rr|
      # log.debug rr.employee.full_name
      @reports << rr.employee.full_name
    }
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee }
    end
  end

end
