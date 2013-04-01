class PeopleController < InheritedResources::Base

  def search
    index
  end

  def index
    if params[:jqst] # being called from jquery token input plugin (expecting json)
      @people = Person.where("name like ?", "%#{params[:jqst]}%")
    else
      @search_params = params[:q]
      logger.info "people#index: search params: -- #{params[:q]} --"

      @search = Person.search(params[:q])
      ppl = @search.result
      @ppl_count = ppl.size
      if request.format == 'text/html'
        @people = ppl.paginate(:per_page => 25, :page => params[:page])
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

end
