require 'spec_helper'

feature "Employee Search" do 

  scenario "as an administrator, the employee search parameters default to 'full name contains'", :js => true, :focus => false do 
    e = create(:employee)
    login
    visit employees_path
    click_on "Search"
    within("#employee_search") do
      page.should have_content "Full name"
      page.should have_content "contains"
      page.should have_content "ascending"
    end
  end


  scenario "I can page through search results", :js => true, :focus => false

  scenario "I can sort search results", :js => true, :focus => false do
    e1 = create(:employee, :full_name => "z")
    e2 = create(:employee, :full_name => "y")
    e3 = create(:employee, :full_name => "x")
    login
    visit employees_path
    within("#search_results") do
      click_on "Id"
      click_on "Id"
      click_on "Full Name"
      click_on "Full Name"
      click_on "Job Title"
      click_on "Job Title"
    end
  end

  scenario "as an administrator, I can export an employee search result to XLS", :js => true, :focus => false

  scenario "as an administrator, I can export an employee search result to CSV", :js => true, :focus => false

  scenario "as an administrator, I can search for employees based upon their attributes", :js => true, :focus => false

  scenario "as an administrator, I can search for employees based upon their supervisor's attributes", :js => true, :focus => false

  scenario "as an administrator, I can search for employees based upon their subordinate's attributes", :js => true, :focus => false

end
