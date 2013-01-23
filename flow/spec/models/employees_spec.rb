# https://www.relishapp.com/rspec/rspec-expectations/v/2-6/docs/built-in-matchers

require 'spec_helper'
require 'yaml'

describe "Employees Model" do 

  it "only has one solid line reporting relationship"

  it "can have multiple dotted line reporting relationships"

  it "finds eligible subordinates even when you have no subordinates (bug)" do
    employee = create(:employee)
    subordinate_orphan1 = create(:employee, full_name: "Subordinate Orphan1", job_title: "Subordinate Title")
    subordinate_orphan2 = create(:employee, full_name: "Subordinate Orphan2", job_title: "Subordinate Title")
    subordinate_orphan3 = create(:employee, full_name: "Subordinate Orphan3", job_title: "Subordinate Title")
    eligible_subordinates = Employee.eligible_subordinates(employee)
    eligible_subordinates.size.should == 3
  end

  it "finds eligible supervisors even when you have no supervisors (bug)" do
    employee = create(:employee)
    supervisor_orphan1 = create(:employee, full_name: "Supervisor Orphan1", job_title: "Supervisor Title")
    supervisor_orphan2 = create(:employee, full_name: "Supervisor Orphan2", job_title: "Supervisor Title")
    supervisor_orphan3 = create(:employee, full_name: "Supervisor Orphan3", job_title: "Supervisor Title")
    eligible_supervisors = Employee.eligible_supervisors(employee)
    eligible_supervisors.size.should == 3
  end

  it "finds only employees who are not the current employee's subordinates when pupulating a reporting relationship pick list" do 
    employee = create(:employee)
    subordinate = create(:employee, full_name: "Subordinate", job_title: "Subordinate Title")
    subordinate_orphan = create(:employee, full_name: "Subordinate Orphan", job_title: "Subordinate Title")
    subordinate_orphan2 = create(:employee, full_name: "Subordinate Orphan2", job_title: "Subordinate Title")

    employee.subordinates << subordinate

    eligible_subordinates = Employee.eligible_subordinates(employee)

    # is the current employee id in the list?
    results = eligible_subordinates.find {|s| s.id == employee.id}
    results.should be_nil

    # todo improve this loop
    # is anyone from the current subordinates list in the list?
    eligible_subordinates.each {|es|
      employee.subordinates.each{|s|
        s.id.should_not equal(es.id)
      }
    }

  end

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

  it "can not add itself as a supervisor or subordinate", :focus => false do
    employee = create(:employee)
    lambda { employee.subordinates << employee }.should raise_error ActiveRecord::RecordInvalid
  end
  
end
