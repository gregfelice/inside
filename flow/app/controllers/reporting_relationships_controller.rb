class ReportingRelationshipsController < InheritedResources::Base

  def new
    @employee = Employee.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employee }
    end
  end

  def create
    supervisor = Employee.find(params[:supervisor_id])
    subordinate = Employee.find(params[:subordinate_id])
    @employee = supervisor

    begin supervisor.subordinates << subordinate
      flash[:notice] = "Added report."
      redirect_to employee_path(@employee)
    rescue
      flash[:error] = "Unable to add report."
      redirect_to :back
    end
  end
  
  def destroy
    @reporting_relationship = ReportingRelationship.find(params[:id])
    @reporting_relationship.destroy
    flash[:notice] = "Removed Reporting Relationship."
    redirect_to :back
  end
  
  
end
