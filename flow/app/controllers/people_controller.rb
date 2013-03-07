class PeopleController < InheritedResources::Base

  def index
    if params[:term] # autocomplete field call
      @people = Person.order(:name).where("name like ?", "%#{params[:term]}%")
      render json: @people.map(&:name) # todo - change this to name, ido
    else
      @people = Person.all
      respond_to do |format|
        format.html
        format.json { render json: @people }
      end
    end
  end

end
