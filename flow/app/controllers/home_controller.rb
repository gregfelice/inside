
class HomeController < ApplicationController

  def index
  end

  def orgchart
    @reporting_relationships = ReportingRelationship.find(:all)
    render :layout => 'orgchart'
  end

  def orgdendro
    # arthur
    @employee = Employee.find_by_id(237)
    render :layout => 'orgchart'
  end
  
end

