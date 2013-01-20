class EmployeesController < InheritedResources::Base

  def index 
    @employees = Employee.search(params[:search]) # support for searches, see model for more details
  end

  def new 
    @employee = Employee.new
  end
  
  #def create 
  #  @employee = Employee.create!(params[:employee])
  #  respond_to do |format|
  #    format.html { redirect_to employees_url }
  #    format.js 
  #  end
  #end

  def show
    @employees = Employee.find(:all, :order => "full_name") # for add a subordinate
    @employee = Employee.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee }
    end
  end

end
