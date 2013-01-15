class EmployeesController < InheritedResources::Base

  def index 
    # support for searches
    @employees = Employee.search(params[:search])
  end

  #def new 
  #  @employee = Employee.new
  #end
  
  # GET /employees/new
  # GET /employees/new.json
  def new
    @employee = Employee.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employee }
      format.js # not executing the jquery stuff.. not sure why it doesn't just fail...
    end
  end
  
end
