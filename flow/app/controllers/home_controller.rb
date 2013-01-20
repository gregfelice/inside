
class HomeController < ApplicationController

  def index
  end

  def orgchart
    @reporting_relationships = ReportingRelationship.find(:all)
    render :layout => 'orgchart'
  end

  def orgdendro
    render :layout => 'orgchart'
  end

  def budgetchart
    render :layout => 'orgchart'
  end

  def budgetchart_dynamic
    render :layout => 'orgchart'
  end

  def orgdendro_tree
    @employee = Employee.find_by_id(183) 
    # @employee = Employee.find_by_id(183) 
    tree = to_node @employee
    respond_to do |format|
      format.json { render json: tree }
    end

  end

  def staffingchart
    render :layout => 'orgchart'
  end
  
  private
  
  def to_node(n)
    {
      "name" => n.full_name,
      "size" => 1000,
      "children" => n.subordinates.size > 0 ? n.subordinates.map { |c| to_node c } : ""
    }
  end

end

