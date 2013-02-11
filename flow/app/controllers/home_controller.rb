
class HomeController < ApplicationController

  def index
  end

  def orgchart
    @reporting_relationships = ReportingRelationship.find(:all)
    render :layout => 'orgchart'
  end

  def orgdendro
    if params[:id]
      @employee = Employee.find_by_id(params[:id])
    else
      @employee = Employee.find_by_id(183) # marc
    end
    render :layout => 'orgchart'
  end

  def budgetchart
    render :layout => 'orgchart'
  end

  def budgetchart_dynamic
    render :layout => 'orgchart'
  end

  def orgdendro_tree
    if params[:id]
      e = Employee.find_by_id(params[:id])
    else
      e = Employee.find_by_id(183) # marc
    end

    tstart = Time.now.to_f
    tree = e.org_context
    tend = Time.now.to_f - tstart
    logger.info "time for tree retrieval: #{tend}"

    respond_to do |format|
      format.json { render json: tree }
    end
  end

  def staffingchart
    render :layout => 'orgchart'
  end

end

