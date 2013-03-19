require 'spec_helper'

feature "People Administration" do

  scenario "as an administrator, I can create a new person", :js => true, :focus => false do
    e = build(:person)
    login
    visit people_path
    page.should have_content "People"
    page.should have_content "New Person"
    click_on "New Person"
    page.should have_content "Name"
    within("#new_person") do
      fill_in "Name", :with => e.name
      fill_in "Title", :with => e.title
    end
    click_on "Update Person"
    page.should have_content "Person was successfully created."
  end



end
