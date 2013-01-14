require 'spec_helper'

feature "Employee Administration" do 

  # begin release 1
  scenario "as an administrator, create a new employee" do
    e = create(:employee)
    visit employees_path
    click_link "New"
    fill_in "Full name", :with => e.full_name
    fill_in "Job title", :with => e.job_title
    click_button "Update Employee"
    page.should have_content "Employee"
  end

=begin
  http://railscasts.com/episodes/163-self-referential-association?autoplay=true
  http://www.jacklmoore.com/notes/jquery-modal-tutorial

  http://twitter.github.com/bootstrap/javascript.html#modals

ok - i think what happens here is that this is stateless - i present a screen that -- has a link to perform the action of association - 
needs to remember the original person - we can then 'add' them to this -- where the fuck do we save this ... pass as a parameter, 

=end
  scenario "as an administrator, add new subordinates for an employee" do
  # given i am an administrator
  #   and i am in a show employee screen (not edit employee)
  # when click_button add_new_report
  #   and i see a modal screen with an entry box for a full_name
  #   and i enter a name for a new employee to move
  #   and i see a return set that has the person i want 
  #   and i select that person (or those people)
  # then i see the system has added that person as a subordinate

# note here: we need to view this as a true move relationship... but what in the case of dotted? do we preserve them?

# in general, we need a lightbox screen that pops up for an employee search. start with a single search..
# looks like we can use boot strap for modal dialogs

# ok - now what -- we want to present the equivalent of the index.html of all employees, as filterable, but also include an action button that
# associates that employee with our person. we want to do all of this in a modal window. hmm. 
# sheez.



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
