require 'spec_helper'

include Warden::Test::Helpers
include FactoryGirl::Syntax::Methods

Warden.test_mode!

def login
  print "LOGGING IN"
  user = nil
  begin
    user = User.find_by_email("test_user@test.com")
  rescue ActiveRecord::RecordNotFound
    user = create(:user, :email => "test_user@test.com", :password => "p4ssw0rd___")
  end
  login_as(user, :scope => :user)
end





