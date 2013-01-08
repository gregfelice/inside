
class HomeController < ApplicationController

  def index
  end

  def orgchart
    @reporting_relationships = ReportingRelationship.find(:all)
  end
  
end

