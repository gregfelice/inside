require 'spec_helper'
require 'yaml'

describe "Tree Model" do

  it "has a tree that works", :focus => false do
    a1 = create(:employee)
    b1 = create(:employee)
    c1 = create(:employee)
    c2 = create(:employee)
    d1 = create(:employee)
    d2 = create(:employee)

    b1.add_supervisor a1

    b1.add_subordinate c1
    b1.add_subordinate c2

    c1.add_subordinate d1
    c1.add_subordinate d2

    puts "A1: " + a1.inspect

=begin
ah. i think this is invalidating the data everytime, because we are using stale ids.... hah. turn_off_cache option is needed here for tests. 
=end

    ReportingRelationshipsTree.instance.set_top_node_id(a1.id)
    ReportingRelationshipsTree.instance.touch_direct_reporting_relationships_tree
    sleep 4

    tree = ReportingRelationshipsTree.instance.get_direct_reporting_relationships_tree(a1)
    puts "tree: " + tree.inspect
  end

  it "retrieves a tree for me that starts at my supervisor as top node", :focus => false do
    true.should == false
  end

  it "correctly retrieves a tree for me even if i dont have a supervisor", :focus => false do
    true.should == false
  end



end
