class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :authenticate_user!, :application_vars

  # redirect me to home on cancan access denied
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  def application_vars
    @employees_count = Person.count
  end

end
