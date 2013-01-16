class ReportingRelationshipsController < InheritedResources::Base

  # GET /employees/new
  # GET /employees/new.json
  def new
    @employee = Employee.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employee }
    end
  end

  # simple for now - don't deal with dotteds.
  def create
    logger.debug params.inspect

    supervisor = Employee.find(params[:supervisor_id])
    subordinate = Employee.find(params[:subordinate_id])

    @employee = supervisor

    begin supervisor.subordinates << subordinate
      flash[:notice] = "Added report."
      redirect_to employee_path(@employee)
    rescue
      flash[:error] = "Unable to add report."
      redirect_to employee_path(@employee)
    end
  end
  
  def destroy
    @reporting_relationship = current_user.reporting_relationships.find(params[:id])
    @reporting_relationship.destroy
    flash[:notice] = "Removed reporting_relationship."
    redirect_to current_user
  end
  
  
end
