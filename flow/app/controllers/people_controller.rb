class PeopleController < InheritedResources::Base

  load_and_authorize_resource

  def search
    index
  end

  def index
    if params[:jqst] # being called from jquery token input plugin (expecting json)
      ppl = Person.where("name like ?", "%#{params[:jqst]}%")
      ppl.each {|p|
        if p.hr_status == 'resigned'
          p.name = p.name + " (Resigned)"
        elsif p.hiring_status != 'hired'
          p.name = p.name + " (Open)"
        end
      }
      @people = ppl
    else
      @search_params = params[:q]
      logger.info "people#index: search params: -- #{params[:q]} --"

      @search = Person.search(params[:q])
      ppl = @search.result
      @ppl_count = ppl.size
      if request.format == 'text/html'
        @people = ppl.paginate(:per_page => 15, :page => params[:page])
      else
        @people = ppl
      end
      @search.build_condition if @search.conditions.empty?
      @search.build_sort if @search.sorts.empty?
    end
    respond_to do |format|
      format.html { render :template => 'people/index' }
      format.json { render json: @people.map(&:attributes) }
      format.csv { send_data @people.to_csv }
      format.xls
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      post_activity nil, "viewed person #{@person.name}"
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end


  ###################### system writes ############################

  def post_activity(object, summary)
    activity = Activity.new
    activity.owner = User.find(current_user).email
    #activity.summary = "#{summary}: #{object.changed if !object.nil?}" TODO - get this working
    activity.summary = "#{summary}"
    activity.save!
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render json: @person, status: :created, location: @person }
        post_activity @person, "created person #{@person.name}"
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
        post_activity @person, "updated person #{@person.name}"
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    person_name = @person.name
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url, notice: "Person was successfully destroyed." }
      format.json { head :no_content }
      post_activity @person, "deleted person #{person_name}"
    end
  end

  def edit_multiple
    if !params[:person_ids]
      respond_to do |format|
        format.html { redirect_to people_path, notice: "Nobody was checked!!" }
      end
    else
      @people = Person.find(params[:person_ids])
    end
  end

  def update_multiple
    @people = Person.find(params[:person_ids])
    @people.reject! do |person|
      post_activity person, "updated person #{person.name}"
      person.update_attributes(params[:person].reject { |k,v| v.blank? })
    end
    if @people.empty?
      redirect_to people_url, notice: "People successfully updated."
    else
      @person = Person.new(params[:person])
      render "edit_multiple"
    end
  end

end
