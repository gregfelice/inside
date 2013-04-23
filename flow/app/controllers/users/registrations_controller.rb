class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :check_permissions, :only => [:new, :create, :cancel]

  # remove devise allowing any actions with no authentication
  skip_before_filter :require_no_authentication

  # check cancan to see if I have permissions to create users
  def check_permissions
    authorize! :create, resource
  end

end
