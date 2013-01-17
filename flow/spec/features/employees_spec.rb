require 'spec_helper'

feature "Employee Administration" do 

  # begin release 1
  scenario "as an administrator, create a new employee" do
    e = create(:employee)
    login('admin', 'scene24')
    visit employees_path
    click_link "New"
    fill_in "Full name", :with => e.full_name
    fill_in "Job title", :with => e.job_title
    click_button "Update Employee"
    page.should have_content "Employee"
  end

  # As an administrator
  # When I go to the show page for an employee
  #   and I click on add a report
  #   and I see a modal appear with a entry box
  #   and I enter a substring
  #   and I see names that match that search
  #   and I choose a name
  # Then I see te modal close
  #   and I see the main show page
  #   and I see the employee added to the reports list for the employee
  
  scenario "as an administrator, add new subordinates for an employee" do 
    # test the search window in the modal
  end

  scenario "as an administrator, remove subordinates for an employee" do
  end

  scenario "as an administrator, move subordinates from an employee to another employee"

################################

  scenario "as an administrator, change an employee's supervisor"  
  
=begin
http://railscasts.com/episodes/165-edit-multiple?view=asciicast
=end
  scenario "as an administrator, filter on a list of employees and bulk change their supervisor"

  scenario "as a user, search for employees"

  scenario "as a user, view a employee profile"

  scenario "as an administrator, hard delete an employee"

  scenario "as an administrator, soft delete an employee, and provide a reason for the delete"
  # end release 1

  scenario "as an administrator, modify someone's access rights"
  

end
