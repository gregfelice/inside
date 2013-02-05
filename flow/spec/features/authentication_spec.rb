require 'spec_helper'

feature "Authentication" do 
  
  scenario "I can log in", :js => true, :focus => true do

    login
    visit employees_path
    page.should have_content "Logout"

  end

  scenario "I can log out", :js => true, :focus => false
  
end
