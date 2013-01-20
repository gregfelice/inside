require 'spec_helper'

# include Warden::Test::Helpers

feature "Employee Administration" do 
  
  scenario "as an administrator, create a new employee", :js => true, :focus => false do
    e = build(:employee)
    visit employees_path
    click_on "New"
    fill_in "Full name", :with => e.full_name
    fill_in "Job title", :with => e.job_title
    click_on "Update Employee"
    page.should have_content "Employee was successfully created."
  end
  
  scenario "as a user, search for employees", :js => true, :focus => false do
    create(:employee, full_name: 'asdad')
    create(:employee, full_name: "abignail breooderxx")
    create(:employee, full_name: "cookie monster")    
    create(:employee, full_name: "elanor rigby")
    create(:employee, full_name: "d00d!")        
    visit employees_path
    page.should have_content "cookie monster"
    page.should have_content "elanor rigby"
    fill_in 'search', :with => 'elanor'
    click_button 'Search'
    page.should_not have_content "cookie monster"
    page.should have_content "elanor rigby"
  end

  scenario "as a user, view a employee profile"
  scenario "as an administrator, hard delete an employee"

end

## seems to work, with js == false 
# Warden.test_mode!
# user = create(:user, :email => "gregfelice@gmail.com", :password => "_Kn1ves0ut")
# login_as(user, :scope => :user)
##

