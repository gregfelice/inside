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

    # no_cycles = detect_cycles(params)
    no_cycles = true

    respond_to do |format|
      if no_cycles && @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render json: @employee, status: :created, location: @employee }
      else
        format.html { render action: "new" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

=begin

  def detect_cycles_all(params)
    return false if !detect_cycles(params, :direct_supervisor_tokens)
    return false if !detect_cycles(params, :dotted_supervisor_tokens)
    return false if !detect_cycles(params, :direct_subordinate_tokens)
    return false if !detect_cycles(params, :dotted_subordinate_tokens)
    return true
  end

  def detect_cycles(params, field)

    # works for direct supervisor field right now. -- needs to work for other 3.

    ############################################################################################
    id_params = params[:employee][field].split(",").map(&:to_i)       # from the front end & database
    id_saved = @employee.method(field).call                           # from the database
    id_unsaved = id_params - id_saved                                 # subtracting out the saved, leaving the new

    h = Employee.build_adjacency_list_ids(:direct_reporting)          # build adjacency list of ids for a specific relationship type

    id_unsaved.each {|supervisor_id|                                  # add the unsaved tokens to the list
      h[supervisor_id] = [] if h[supervisor_id].nil?
      h[supervisor_id] << @employee.new_record? ? 0 : @employee.id
    }
    ############################################################################################

    # test for scc (strongly connnected components AKA cycles)
    scc = Employee.get_graph_cycles(h)
    logger.info "cycles report: #{scc.inspect}"

    no_cycles = nil
    if scc.size > 0 # halt!
      no_cycles = false
      cycles_names = []
      scc.each {|s| # s is an array of all employee ids caught in the cycle
        e = Employee.find(s).map {|e| e.full_name}
        cycles_names << e
      }
      cycles_names.flatten!
      cycles_message = "Cycle detected with the following people: #{cycles_names.join(", ")}. New supervisor entries cleared."
      @employee.errors.clear
      @employee.errors[:base] << cycles_message
    else
      no_cycles = true
    end
    no_cycles
  end
=end

  def update

    @employee = Employee.find(params[:id])

    # no_cycles = detect_cycles_all(params)
    no_cycles = true

    respond_to do |format|
      if no_cycles && @employee.update_attributes(params[:employee])
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        alert = ""
        @employee.errors[:base].each {|e| alert << e}
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
