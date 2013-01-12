require 'test_helper'

describe Employee do

  it "can be created and deleted" do 
    e = Employee.create!(full_name: "Joe Smith", job_title: "President")
    e.full_name.must_equal "Joe Smith"
    e.save!
    eid = e.id
    Employee.destroy(eid)
    assert_raises(ActiveRecord::RecordNotFound) { Employee.find(eid) }
  end
  
  it "can add employees that report to it"

  it "can add employees is reports to"

end
