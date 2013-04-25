require 'spec_helper'

feature "Authentication" do

  scenario "I can log in", :js => true, :focus => true do
    login
    visit people_path
    page.should have_content "Logout"
  end

end
