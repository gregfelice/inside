require 'singleton'

class ReportingRelationshipsTree
  include Singleton

  attr_accessor :top_node_id
  @top_node_id = nil

  def get_direct_reporting_relationships_tree(employee)
    Rails.logger.info "using employee #{employee.inspect} to get tree"
    get_tree(employee)
  end

  def set_top_node_id(id)
    @top_node_id = id
  end

  def initialize
    @top_node_id = CONFIG[:top_node_id]
    Rails.logger.info "reporting_relationships_tree singleton initialized with top node id of #{@top_node_id}."
  end

  private

  # if i have no supervisor, return me
  def get_tree_top_id(employee)
    if employee.supervisor_relationships.empty?
      employee.id
    else
      sup = employee.supervisor_relationships.reject{|sr| sr.dotted == true}.first
      sup.supervisor_id
    end
  end


  # get a reporting tree starting from this employee's boss, down to all leaf subordinates.
  def get_tree(employee)

    h = Employee.build_adjacency_list

    n = h[get_tree_top_id(employee)] # start creating the tree at this employee's supervisor, if there is one

    nodes = to_node(h, n)            # recurse through the SQL results to construct a tree (nested hashes)

    nodes
  end

  # starting at a top employee node, recurse through all subordinate relationships to create a nested reporting structure tree
  def to_node(h, n, i=0)
    i = i + 1
    {
      "id" => n[:id],
      "name" => n[:name],
      "size" => 1,
      "children" => n[:children].empty? ? "" : n[:children].map { |c|
        c[:children] = get_children(h, c)
        to_node h, c, i
      }
    }
  end

  # get children from the hash in memory based on supervisor id
  def get_children(h, n)
    rr = h[n[:id]]
    if !rr.nil?
      rr[:children]
    else
      []
    end
  end

end
