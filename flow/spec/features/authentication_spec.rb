require 'spec_helper'
require 'authentication_helper'

feature "Authentication" do 
  
  scenario "I can log in", :js => true, :focus => true do
    login
  end
  
end
