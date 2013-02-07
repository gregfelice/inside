require 'spec_helper'

feature "Employee Administration" do

  scenario "as an administrator, I can delete an employee", :js => true, :focus => true do
    employee = create(:employee)
    login
    visit employee_path(employee.id)
    click_on "Destroy"
    # http://stackoverflow.com/questions/2458632/how-to-test-a-confirm-dialog-with-cucumber
    page.driver.browser.switch_to.alert.accept
    page.should have_content "Employee was successfully deleted."
  end

  scenario "throws a validation error if a omit name on new employee", :js => true, :focus => false do
    e = build(:employee)
    login
    visit employees_path
    page.should have_content "Employees"
    page.should have_content "New Employee"
    click_on "New Employee"
    page.should have_content "Full name"
    within("#new_employee") do
      fill_in "Job title", :with => e.job_title
    end

    click_on "Update Employee"
    page.should have_content "can't be blank"
  end

  scenario "I can add a direct supervisor for an employee", :js => true, :focus => false do

    employee = create(:employee)
    supervisor = create(:employee, full_name: 'Jacob Brown')
    login
    visit employee_path(employee.id)
    click_on "Edit"
    fill_in_token_input 'token-input-employee_direct_supervisor_tokens', supervisor.full_name
    wait_for_ajax do
      click_on "Update Employee"
    end
    page.should have_content "Employee was successfully updated."
    page.should have_content supervisor.full_name
  end

  scenario "I can add a dotted supervisor for an employee", :js => true, :focus => false do
    employee = create(:employee)
    supervisor = create(:employee, full_name: 'Jacob Brown')
    login
    visit employee_path(employee.id)
    click_on "Edit"
    fill_in_token_input 'token-input-employee_dotted_supervisor_tokens', supervisor.full_name
    wait_for_ajax do
      click_on "Update Employee"
    end
    page.should have_content "Employee was successfully updated."
    page.should have_content supervisor.full_name
    page.should have_content "dotted"
  end

  scenario "as an administrator, when I update an employee, and add a reporting relationship for an employee, I cannot create a circular relationship", :js => true, :focus => false do
    employee = create(:employee)
    login
    visit employee_path(employee.id)
    click_on "Edit"
    fill_in_token_input 'token-input-employee_direct_supervisor_tokens', employee.full_name
    wait_for_ajax do
      click_on "Update Employee"
    end
    page.should have_content "Invalid circular relationship"
  end


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

