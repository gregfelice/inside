# https://www.relishapp.com/rspec/rspec-expectations/v/2-6/docs/built-in-matchers

require 'spec_helper'
require 'yaml'

describe "Employees Model" do 

  it "only has one solid line reporting relationship"

  it "can have multiple dotted line reporting relationships"

  it "can add and access supervisors and subordinates", :focus => false do
    
    employee = create(:employee)
    supervisor = create(:employee, full_name: "Supervisor", job_title: "Supervisor Title X")
    subordinate = create(:employee, full_name: "Subordinate", job_title: "Subordinate Title X")
    
    supervisor2 = create(:employee, full_name: "Supervisor2", job_title: "Supervisor Title2")
    subordinate2 = create(:employee, full_name: "Subordinate2", job_title: "Subordinate Title2")
    
    employee.supervisors << supervisor
    employee.subordinates << subordinate
    employee.supervisors << supervisor2
    employee.subordinates << subordinate2
    
    # random sanity checks
    employee.supervisors.first.full_name.should eql(supervisor.full_name)

  end

  it "can access the reporting relationship to supervisors and subordinates, and make them dotted", :focus => false do

    employee = create(:employee)
    supervisor = create(:employee, full_name: "Supervisor", job_title: "Supervisor Title")
    subordinate = create(:employee, full_name: "Subordinate", job_title: "Subordinate Title")

    employee.supervisors << supervisor
    employee.subordinates << subordinate
    
    rr = employee.supervisor_relationships.first
    rr.supervisor
    rr.dotted = true
    rr.dotted.should be_true
    
    rr = employee.subordinate_relationships.first
    rr.subordinate
    rr.dotted = true
    rr.dotted.should be_true
    
  end
  
  it "throws an error if the same supervisor or subordinate is added more than once", :focus => false do

    employee = create(:employee)
    supervisor = create(:employee, full_name: "Supervisor", job_title: "Supervisor Title")
    subordinate = create(:employee, full_name: "Subordinate", job_title: "Subordinate Title")

    employee.supervisors << supervisor
    employee.subordinates << subordinate

    expect { employee.supervisors << supervisor }.to raise_error(ActiveRecord::RecordInvalid)
    expect { employee.subordinates << subordinate }.to raise_error(ActiveRecord::RecordInvalid)

  end

  it "can not add itself as a supervisor or subordinate", :focus => false

  
end
