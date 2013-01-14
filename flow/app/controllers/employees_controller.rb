class EmployeesController < InheritedResources::Base

  def index 
    # support for modal search screens
    @employees = Employee.search(params[:search])
  end

end
