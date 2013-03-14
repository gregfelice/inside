require 'spec_helper'
require 'yaml'

describe "People Tree Service" do

=begin
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

    # c1.add_subordinate a1

    ReportingRelationshipsTree.instance.set_top_node_id(a1.id)

    tree = ReportingRelationshipsTree.instance.get_direct_reporting_relationships_tree(a1)
    # puts "tree: " + tree.to_yaml
  end
=end

  it "can report the default top node id", :focus => true do

    p = create(:person)
    s = create(:person)

    p.add_direct_supervisor(s)
    p.save!

    PeopleTree.instance.set_top_node_id(p.id)
    PeopleTree.instance.top_node_id.should == p.id

  end

end
