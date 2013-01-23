require 'spec_helper'

feature "Employee Administration" do 

  scenario "as an administrator, I can add a supervisor to an employee", :js => true, :focus => true do
    employee = create(:employee)
    supervisor = create(:employee, full_name: "Supervisor Child", job_title: "Supervisor Title")

    login
    visit employees_path
    click_link employee.id.to_s
    click_on "Add a Supervisor"

    page.has_content?("Add Supervisor")

    within_table("eligible_supervisors") do
      click_link "Add Supervisor"
    end

    wait_for_ajax do     
      page.should have_content "Added report"
    end
  end
  
  scenario "as an administrator, when I add a subordinate relationship, I do not see current employee or current subordinates in the picklist", :js => true, :focus => false do 
    
    employee = create(:employee)
    subordinate = create(:employee, full_name: "Subordinate Child", job_title: "Subordinate Title")
    subordinate_orphan = create(:employee, full_name: "Subordinate Orphan", job_title: "Subordinate Title")
    subordinate_orphan2 = create(:employee, full_name: "Subordinate Orphan2", job_title: "Subordinate Title")
    
    employee.subordinates << subordinate
    
    login
    visit employees_path
    click_link employee.id.to_s
    click_on "Add a Report"
    
    within_table("eligible_subordinates") do
      page.should have_content subordinate_orphan.full_name
      page.should have_content subordinate_orphan2.full_name
      page.should_not have_content employee.full_name
      page.should_not have_content subordinate.full_name
    end
  end

  scenario "as an administrator, when I add a supervisor relationship, I do not see current employee or supervisors in the picklist", :js => true, :focus => false do

    employee = create(:employee)
    supervisor = create(:employee, full_name: "Supervisor Child", job_title: "Supervisor Title")
    supervisor_orphan = create(:employee, full_name: "Supervisor Orphan", job_title: "Supervisor Title")
    supervisor_orphan2 = create(:employee, full_name: "Supervisor Orphan2", job_title: "Supervisor Title")

    employee.supervisors << supervisor

    login
    visit employees_path
    click_link employee.id.to_s
    click_on "Add a Report"

    within_table("eligible_supervisors") do
      page.should have_content supervisor_orphan.full_name
      page.should have_content supervisor_orphan2.full_name
      page.should_not have_content employee.full_name
      page.should_not have_content supervisor.full_name
    end
  end

  scenario "as an administrator, I can create a new employee", :js => true, :focus => false do
    e = build(:employee)

    login

    visit employees_path
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

  scenario "as a user, I can view an employee profile", :focus => false do
    e = create(:employee, full_name: 'Jacob Brown')

    login

    visit employee_path(e.id)
    page.should have_content "Jacob Brown"
  end

  # scenario "as an administrator, hard delete an employee"
  
end

