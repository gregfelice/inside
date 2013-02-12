require 'spec_helper'

describe "Employees Model" do

  it "appropriately marks itself as dirty if i change an association", :focus => false do
    employee = create(:employee)
    employee.changed?.should be_false

    employee.full_name = "change me"
    employee.changed?.should be_true

    employee2 = create(:employee)
    employee3 = create(:employee)
    employee2.add_subordinate employee3

    employee2.changed?.should be_true

  end

  it "initializes reporting relationship to dotted on new", :focus => false do
    r = ReportingRelationship.new
    r.dotted.should be_false
  end

  it "can use << notation to push objects onto relationships", :focus => false do
    employee = create(:employee)
    subordinate = create(:employee, full_name: "Subordinate Full Name", job_title: "Subordinate Title")
    employee.subordinates << subordinate
    ReportingRelationship.all.each { |rr| rr.dotted.should_not be_nil }
  end

  it "initializes the reporting relationship dotted to false on save if its not initialized", :focus => false do 
    employee = create(:employee)
    subordinate = create(:employee, full_name: "Subordinate Full Name", job_title: "Subordinate Title")
    supervisor = create(:employee, full_name: "Supervisor Full Name", job_title: "Supervisor Title")
    employee.subordinates << subordinate
    employee.supervisors << supervisor
    employee.supervisors.size.should == 1
    employee.subordinates.size.should == 1
    rr = employee.subordinate_relationships.first
    rr.dotted.should == false
    rr = employee.supervisor_relationships.first
    rr.dotted.should == false
  end

  it "destroys reporting relationships correctly upon dissassociation", :focus => false do
    employee = create(:employee)
    subordinate = create(:employee, full_name: "Subordinate Full Name", job_title: "Subordinate Title")
    employee.subordinates << subordinate
    expect { ReportingRelationship.find_by_supervisor_id!(employee.id) }.to_not raise_error(ActiveRecord::RecordNotFound)
    employee.subordinates.size.should == 1
    employee.subordinate_relationships.clear
    expect { ReportingRelationship.find_by_supervisor_id!(employee.id) }.to raise_error(ActiveRecord::RecordNotFound)
    employee.subordinates.size.should == 0
    ReportingRelationship.all.size.should == 0
  end

  it "can save a new supervisor relationship, and set the relationship to dotted", :focus => false do
    employee = create(:employee)
    supervisor1 = create(:employee, full_name: "Supervisor1", job_title: "Supervisor Title")
    employee.supervisor_relationships.build(:dotted => true, :supervisor => supervisor1, :subordinate => employee)
    employee.save
    employee.supervisors.size.should == 1
  end

  it "can retrieve a list of dotted OR direct supervisor tokens for an employee", :focus => false do
    employee = create(:employee)
    supervisor1 = create(:employee, full_name: "Supervisor1", job_title: "Supervisor Title")
    supervisor2 = create(:employee, full_name: "Supervisor2", job_title: "Supervisor Title")
    supervisor3 = create(:employee, full_name: "Supervisor3", job_title: "Supervisor Title")
    employee.supervisors << supervisor1
    employee.supervisors << supervisor2
    employee.supervisors << supervisor3
    sr2 = ReportingRelationship.find_by_supervisor_id!(supervisor2)
    sr2.dotted = true
    sr2.save
    sr3 = ReportingRelationship.find_by_supervisor_id!(supervisor3)
    sr3.dotted = true
    sr3.save
    dotted_ids = employee.dotted_supervisor_tokens
    dotted_ids.size.should == 2
    direct_ids = employee.direct_supervisor_tokens
    direct_ids.size.should == 1
    # now, attempt to save supervisors to the token interface
    supervisor4 = create(:employee, full_name: "Supervisor4", job_title: "Supervisor Title")
    all_ids = employee.supervisor_ids
    all_ids.size.should == 3
    dotted_ids.size.should == 2
    dotted_ids << supervisor4.id
    dotted_ids.size.should == 3
    employee.dotted_supervisor_tokens = dotted_ids
    employee.save!
    employee.supervisor_ids.size.should == 4
    employee.supervisors.size.should == 4
  end

  it "can retrieve a list of dotted OR direct supervisors for an employee", :focus => false do
    employee = create(:employee)
    supervisor1 = create(:employee, full_name: "Supervisor1", job_title: "Supervisor Title")
    supervisor2 = create(:employee, full_name: "Supervisor2", job_title: "Supervisor Title")
    employee.supervisors << supervisor1
    employee.supervisors << supervisor2
    sr2 = ReportingRelationship.find_by_supervisor_id(supervisor2)
    sr2.dotted = true
    sr2.save
    employee.supervisors.size.should == 2
    ds = Employee.dotted_supervisors(employee)
    ds.size.should == 1
    ds.first.full_name.should == supervisor2.full_name
    dss = Employee.direct_supervisors(employee)
    dss.size.should == 1
    dss.first.full_name.should == supervisor1.full_name
  end

  it "finds eligible subordinates even when you have no subordinates" do
    employee = create(:employee)
    subordinate_orphan1 = create(:employee, full_name: "Subordinate Orphan1", job_title: "Subordinate Title")
    subordinate_orphan2 = create(:employee, full_name: "Subordinate Orphan2", job_title: "Subordinate Title")
    subordinate_orphan3 = create(:employee, full_name: "Subordinate Orphan3", job_title: "Subordinate Title")
    eligible_subordinates = Employee.eligible_subordinates(employee)
    eligible_subordinates.size.should == 3
  end

  it "finds eligible supervisors even when you have no supervisors" do
    employee = create(:employee)
    supervisor_orphan1 = create(:employee, full_name: "Supervisor Orphan1", job_title: "Supervisor Title")
    supervisor_orphan2 = create(:employee, full_name: "Supervisor Orphan2", job_title: "Supervisor Title")
    supervisor_orphan3 = create(:employee, full_name: "Supervisor Orphan3", job_title: "Supervisor Title")
    eligible_supervisors = Employee.eligible_supervisors(employee)
    eligible_supervisors.size.should == 3
  end

  it "finds only employees who are not the current employee's subordinates when populating a reporting relationship pick list" do 
    employee = create(:employee)
    subordinate = create(:employee, full_name: "Subordinate", job_title: "Subordinate Title")
    subordinate_orphan = create(:employee, full_name: "Subordinate Orphan", job_title: "Subordinate Title")
    subordinate_orphan2 = create(:employee, full_name: "Subordinate Orphan2", job_title: "Subordinate Title")
    employee.subordinates subordinate
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
    employee.subordinates.size.should == 2
    # random sanity checks
    employee.subordinates.first.full_name.should eql(subordinate.full_name)
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
    expect { employee.subordinates << employee }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "will contain valid error messages if i add itself as a supervisor or subordinate", :focus => false do
    employee = create(:employee)
    subordinate = create(:employee, :full_name => "Foo Name")
    employee.full_name = nil
    begin
      employee.save!
    rescue
      # puts "employee errors: #{employee.errors.inspect}"
    end
    begin
      employee.subordinates << subordinate
      employee.subordinates << employee
    rescue
      other_errors = []
      other_errors << employee.subordinate_relationships.reject { |sr| sr.valid? }.collect { |sr| sr.errors }
      # puts other_errors.inspect
    end
    employee.subordinate_relationships.reject { |sr| sr.valid? }.each { |sr| sr.errors.messages.each { |key, value| employee.errors.add(key, value) } }
    employee.errors.inspect.index('Invalid circular relationship').size.should be > 0
  end

end
