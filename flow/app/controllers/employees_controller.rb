class EmployeesController < InheritedResources::Base

  def index 
    @employees = Employee.search(params[:search]) # support for searches
  end

  def new 
    @employee = Employee.new
  end
  
  def new
    @employee = Employee.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employee }
      format.js # not executing the jquery stuff.. not sure why it doesn't just fail...
    end
  end
  
  def create 
    @employee = Employee.create!(params[:employee])
    respond_to do |format|
      format.html { redirect_to employees_url }
      format.js 
    end
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    @employees = Employee.find(:all) # for add a subordinate
    
    @employee = Employee.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee }
    end
  end


end
