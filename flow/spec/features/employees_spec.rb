require 'spec_helper'

feature "Employee Administration" do 

  scenario "as an administrator, I can add a dotted line relationship"

  scenario "as an administrator, I can create a new employee", :js => true, :focus => false do
    e = build(:employee)
    
    login
    visit employees_path
    page.should have_content "Employees"
    click_on "New"
    fill_in "Full name", :with => e.full_name
    fill_in "Job title", :with => e.job_title
    click_on "Update Employee"
    page.should have_content "Employee was successfully created."
  end
  
  scenario "as a user, I can search for employees", :js => true, :focus => false do
    create(:employee, full_name: 'asdad')
    create(:employee, full_name: "abignail breooderxx")
    create(:employee, full_name: "cookie monster")    
    create(:employee, full_name: "elanor rigby")
    create(:employee, full_name: "d00d!")        

    login
    visit employees_path
    page.should have_content "cookie monster"
    page.should have_content "elanor rigby"
    fill_in 'search', :with => 'elanor'
    click_button 'Search'
    page.should_not have_content "cookie monster"
    page.should have_content "elanor rigby"
  end
  
  scenario "as a user, I can view an employee profile", :js => true, :focus => false do
    e = create(:employee, full_name: 'Jacob Brown')
    
    login
    visit employee_path(e.id)
    page.should have_content "Jacob Brown"
  end
  
end

