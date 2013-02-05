require 'spec_helper'

feature "Employee Administration" do 

  scenario "as an administrator, I can add a direct supervisor for an employee", :js => true, :focus => false

  scenario "as an administrator, I can add a dotted supervisor for an employee", :js => true, :focus => false

  # test not working, can't get selenium to see token field...
  #scenario "as an administrator, I can add a subordinate for an employee", :js => true, :focus => false do 
  #  employee = create(:employee)
  #  subordinate = create(:employee, full_name: "Subordinate Full Name", job_title: "Subordinate Title")
  #  
  #  login
  #  visit employees_path
  #
  #  visit employee_path(employee.id)
  #  click_on "Edit"
  #  fill_in "employee_subordinate_tokens", :with => subordinate.full_name
  #  click_on "Update Employee"
  #
  #  page.should have_content "Employee was successfully updated."
  #
  #  end

  scenario "as an administrator, when I add a reporting relationship for an employee, I cannot create a circular relationship", :js => true, :focus => false

  scenario "as an administrator, when I add a reporting relationship for an employee, I cannot add the same person more than once", :js => true, :focus => false

  scenario "as an administrator, I can delete an employee", :js => true, :focus => false

  scenario "as an administrator, when I remove a reporting relationship, the associated reorting relationship is destroyed", :js => true, :focus => false

  scenario "as an administrator, I can view a report of employees with multiple supervisors", :js => true, :focus => false

  scenario "as an administrator, I can create a new employee", :js => true, :focus => false do

    e = build(:employee)

    login
    visit employees_path

    page.should have_content "Employees"
    page.should have_content "New Employee"
    
    click_on "New Employee"
    page.should have_content "Full name"
    
    within("#new_employee") do
      fill_in "Full name", :with => e.full_name
      fill_in "Job title", :with => e.job_title
    end
    
    click_on "Update Employee"
    page.should have_content "Employee was successfully created."
  end
  
  scenario "as a user, I can view an employee profile", :js => true, :focus => false do
    e = create(:employee, full_name: 'Jacob Brown')
    
    login
    visit employees_path

    visit employee_path(e.id)
    page.should have_content "Jacob Brown"

  end
  
end

