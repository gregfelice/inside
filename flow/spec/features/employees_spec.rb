require 'spec_helper'

describe "Employees Feature" do 

  it "new employees can be created with basic attributes" do

    e = FactoryGirl.create(:employee)

    visit employees_path
    click_link "New"
    fill_in "Full name", :with => e.full_name
    fill_in "Job title", :with => e.job_title
    click_button "Update Employee"
    page.should have_content 'Employee'

    # print page.html
  end
  
end
