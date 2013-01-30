require 'spec_helper'

feature "Employee Search" do 

  scenario "as an administrator, the employee search parameters default to 'full name contains'", :js => true, :focus => false

  scenario "as an administrator, I can search for employees based upon their attributes", :js => true, :focus => false

  scenario "as an administrator, I can search for employees based upon their supervisor's attributes", :js => true, :focus => false

  scenario "as an administrator, I can search for employees based upon their subordinate's attributes", :js => true, :focus => false

  scenario "I can page through search results", :js => true, :focus => false

  scenario "I can sort search results", :js => true, :focus => false

  scenario "as an administrator, I can export an employee search result to XLS", :js => true, :focus => false

  scenario "as an administrator, I can export an employee search result to CSV", :js => true, :focus => false

end
