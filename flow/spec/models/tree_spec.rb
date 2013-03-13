require 'spec_helper'
require 'yaml'

describe "Tree Model" do

=begin
  it "can detect cycles in the adjacency list", :focus => true do
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

    c1.add_subordinate a1

    ReportingRelationshipsTree.instance.set_top_node_id(a1.id)

    r = ReportingRelationshipsTree.instance.exec_query
    h = ReportingRelationshipsTree.instance.build_adjacency_list(r)
    puts h.to_yaml

    hh = ReportingRelationshipsTree.instance.build_adjacency_list_ids(r)
    puts hh.to_yaml
    scc = ReportingRelationshipsTree.instance.get_graph_cycles(hh)
    puts scc.inspect

  end
=end

  it "has a tree that works", :focus => true do
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

end
