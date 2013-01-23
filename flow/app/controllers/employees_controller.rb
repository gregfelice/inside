class EmployeesController < InheritedResources::Base

  helper_method :sort_column, :sort_direction

  def index 
    
    if params[:q] # jquery token input
      @employees = Employee.where("full_name like ?", "%#{params[:q]}%")
    else          # all else
      @employees = Employee.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 25, :page => params[:page])
    end

    respond_to do |format|
      format.html
      format.json { render json: @employees.map(&:attributes) }
    end
  end

  def new 
    @employee = Employee.new
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(params[:employee])

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render json: @employee, status: :created, location: @employee }
      else
        format.html { render action: "new" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def show

    @employee = Employee.find(params[:id])
    @eligible_subordinates = Employee.eligible_subordinates(@employee)
    @eligible_supervisors = Employee.eligible_supervisors(@employee)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee }
    end
  end

  private
  
  def sort_column
    Employee.column_names.include?(params[:sort]) ? params[:sort] : "full_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
