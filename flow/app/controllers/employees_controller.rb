class EmployeesController < ApplicationController

  def search
    index
  end

  def index
    if params[:jqst] # being called from jquery token input plugin (expecting json)
      @employees = Employee.where("full_name like ?", "%#{params[:jqst]}%")
    else
      @search_params = params[:q]
      logger.info "employees#index: search params: -- #{params[:q]} --"

      @search = Employee.search(params[:q])
      emps = @search.result
      @emps_count = emps.size
      if request.format == 'text/html'
        @employees = emps.paginate(:per_page => 25, :page => params[:page])
      else
        @employees = emps
      end
      @search.build_condition if @search.conditions.empty?
      @search.build_sort if @search.sorts.empty?
    end
    respond_to do |format|
      format.html { render :template => 'employees/index' }
      format.json { render json: @employees.map(&:attributes) }
      format.csv { send_data @employees.to_csv }
      format.xls
    end
  end

  def show
    @employee = Employee.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee }
    end
  end

  def new
    @employee = Employee.new
  end

  def edit
    @employee = Employee.find(params[:id])
  end

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

  def update
    @employee = Employee.find(params[:id])
    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        alert = ""
        @employee.errors.messages.each {|key, value| alert << "#{key} #{value} "}
        flash[:alert] = alert
        format.html { render action: "edit" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    flash[:notice] = "Employee was successfully deleted."
    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end

end
