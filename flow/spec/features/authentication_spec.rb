require 'spec_helper'

feature "Authentication" do 
  
  scenario "I can log in", :js => true, :focus => false do

    login
    visit employees_path
    page.should have_content "Logout"
  end
  
end
