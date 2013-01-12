
class HomeController < ApplicationController

  def index
  end

  def orgchart
    @reporting_relationships = ReportingRelationship.find(:all)
    render :layout => 'orgchart'
  end

  def orgdendro
    @reporting_relationships = ReportingRelationship.find(:all)
    render :layout => 'orgchart'
  end
  
end

