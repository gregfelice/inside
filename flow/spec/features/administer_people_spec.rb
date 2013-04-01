require 'spec_helper'

feature "Person Administration" do

  scenario "as an administrator, I can delete an person", :js => true, :focus => true do
    person = create(:person)
    login
    visit person_path(person.id)
    click_on "Destroy"
    # http://stackoverflow.com/questions/2458632/how-to-test-a-confirm-dialog-with-cucumber
    page.driver.browser.switch_to.alert.accept
    page.should have_content "Person was successfully destroyed."
  end

  scenario "throws a validation error if a omit name on new person", :js => true, :focus => true do
    e = build(:person)
    login
    visit people_path
    page.should have_content "People"
    page.should have_content "New Person"
    click_on "New Person"
    page.should have_content "Name"
    within("#new_person") do
      fill_in "Title", :with => e.title
    end

    click_on "Update Person"
    page.should have_content "can't be blank"
  end

  scenario "I can add a direct supervisor for an person", :js => true, :focus => true do

    person = create(:person)
    supervisor = create(:person, name: 'Jacob Brown')
    login
    visit person_path(person.id)
    click_on "Edit"
    fill_in_token_input 'token-input-person_direct_supervisor_tokens', supervisor.name
    wait_for_ajax do
      click_on "Update Person"
    end
    page.should have_content "Person was successfully updated."
    page.should have_content supervisor.name
  end

  scenario "I can add a dotted supervisor for an person", :js => true, :focus => true do
    person = create(:person)
    supervisor = create(:person, name: 'Jacob Brown')
    login
    visit person_path(person.id)
    click_on "Edit"
    fill_in_token_input 'token-input-person_dotted_supervisor_tokens', supervisor.name
    wait_for_ajax do
      click_on "Update Person"
    end
    page.should have_content "Person was successfully updated."
    page.should have_content supervisor.name
    page.should have_content "Dotted"
  end

=begin

# commented out for now - a branch will be dedicated to cycle detection improvements
  scenario "as an administrator, when I update an person, and add a reporting relationship for an person, I cannot create a circular relationship", :js => true, :focus => true do
    person = create(:person)
    login
    visit person_path(person.id)
    click_on "Edit"
    fill_in_token_input 'token-input-person_direct_supervisor_tokens', person.name
    wait_for_ajax do
      click_on "Update Person"
    end
    page.should have_content "Invalid circular relationship"
  end
=end

  scenario "as an administrator, I can create a new person", :js => true, :focus => true do
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
      select(e.person_type, :from => 'Person type')
      choose('person_temporary_true')
      choose('person_part_time_true')
      select(e.hr_status, :from => 'Hr status')
    end
    click_on "Update Person"
    page.should have_content "Person was successfully created."
  end

  scenario "as a user, I can view an person profile", :js => true, :focus => true do
    e = create(:person, name: 'Jacob Brown')

    login
    visit people_path

    visit person_path(e.id)
    page.should have_content "Jacob Brown"

  end

end

