require 'release_calendar_rest_client'

class HomeController < ApplicationController

  def index
  end

  def release_calendar
    @releases = ReleaseCalendarRestClient.get_releases
    @releases_by_date = @releases.group_by { |r| r['release_date'] }
    @releases_by_date.each {|a| a[1].sort_by! {|h| h['status']} }
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    respond_to do |format|
      format.html { render :layout => 'orgchart' }
    end
  end

  def release_list
    @releases = ReleaseCalendarRestClient.get_releases
    @releases_by_date = @releases.group_by { |r| r['release_date'] }
    @releases_by_date.each {|a| a[1].sort_by! {|h| h['status']} }
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    respond_to do |format|
      format.html { render :layout => 'orgchart' }
    end
  end



  def orgchart
    @reporting_relationships = ReportingRelationship.where(:dotted => false)
    render :layout => 'orgchart'
  end



  def people_tree
    if params[:id]
      @person = Person.find_by_id(params[:id])
    else
      @person = Person.find_by_id(PeopleTree.instance.top_node_id)
    end
    render :layout => 'orgchart'
  end

  def people_tree_data
    if params[:id]
      person = Person.find_by_id(params[:id])
    else
      person = Person.find(PeopleTree.instance.top_node_id)
    end

    logger.info "top node id from people tree data: #{person.inspect}"

    tree = PeopleTree.instance.get_people_tree(person)
    respond_to do |format|
      format.json { render json: tree }
    end
  end

  def orgdendro
    if params[:id]
      @employee = Employee.find_by_id(params[:id])
    else
      @employee = Employee.find_by_id(ReportingRelationshipsTree.instance.top_node_id)
    end
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




  def budgetchart
    render :layout => 'orgchart'
  end

  def budgetchart_dynamic
    render :layout => 'orgchart'
  end

  def staffingchart
    render :layout => 'orgchart'
  end

end

