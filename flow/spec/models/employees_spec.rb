# https://www.relishapp.com/rspec/rspec-expectations/v/2-6/docs/built-in-matchers

require 'spec_helper'
require 'yaml'

describe "Employees Model" do 

  it "can recurse through the entire tree, starting at the top level boss", :focus => true  do

    employee = create(:employee)

    subordinate_direct_1 = create(:employee, full_name: "Subordinate Direct 1", job_title: "x")
    subordinate_direct_2 = create(:employee, full_name: "Subordinate Direct 2", job_title: "x")
    subordinate_indirect_1 = create(:employee, full_name: "Subordinate Indirect 1", job_title: "x")
    subordinate_indirect_2 = create(:employee, full_name: "Subordinate Indirect 2", job_title: "x")
    
    subordinate_direct_1.subordinates << subordinate_indirect_1
    subordinate_direct_1.subordinates << subordinate_indirect_2

    employee.subordinates << subordinate_direct_1
    employee.subordinates << subordinate_direct_2
    
    # employee.subordinates
    #final = walk(employee, "", 0)
    #puts "final: #{final.to_json}"

    final = to_node(employee).to_json
    puts "final: #{final}"
    
  end
  
  def to_node(n)
    {
      "name" => n.full_name,
      "children" => n.subordinates.map { |c| to_node c }
    }
  end

=begin
  def walk(node, h, level)
    ch = {}
    
    ch[node.full_name] = node.full_name
    ch[:children] = []

    node.subordinates.each {|c|
      ch[:children] << { :name => c.full_name, :size => 1}
      walk(c, h, level += 1)
    }
    puts "level: #{level} node: #{node.full_name} h: #{h}"
    h.merge ch
    h
  end
=end

  it "can retrieve the top level employee", :focus => false do 
    # employee = Employee.find :all, :conditions => { :supervisors })
    # print employee.inspect
  end

  it "can add and access supervisors and subordinates", :focus => false do
    
    employee = create(:employee)
    supervisor = create(:employee, full_name: "Supervisor", job_title: "Supervisor Title")
    subordinate = create(:employee, full_name: "Subordinate", job_title: "Subordinate Title")
    
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
