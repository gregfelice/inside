
class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :authenticate_user!, :application_vars

  #before_filter  :application_vars

  def application_vars
    @employees_count = Employee.count
  end
  
end
