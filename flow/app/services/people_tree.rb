require 'singleton'

class PeopleTree
  include Singleton

  attr_accessor :top_node_id
  @top_node_id = nil

  def get_people_tree(person)
    Rails.logger.info "using person #{person.inspect} to get tree"
    get_tree(person)
  end

  def set_top_node_id(id)
    @top_node_id = id
  end

  def initialize
    begin
      @top_node_id = CONFIG[:people_tree_top_node_id]
      Rails.logger.info "people_tree singleton initialized with top node id of #{@top_node_id}."
    rescue => e
      Rails.logger.error "PeopleTree: could not initialize top node id"
    end
  end

  #private

  # if i have no supervisor, return me
  def get_tree_top_id(person)
    person.direct_supervisors.empty? ? person.id : person.direct_supervisors.first.id
  end


  # get a reporting tree starting from this person's boss, down to all leaf subordinates.
  def get_tree(person)

    h = build_adjacency_list

    n = h[get_tree_top_id(person)] # start creating the tree at this person's supervisor, if there is one

    nodes = to_node(h, n)            # recurse through the SQL results to construct a tree (nested hashes)

    nodes
  end

  # starting at a top person node, recurse through all subordinate relationships to create a nested reporting structure tree
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

  # select the direct reporting relationships and all associated person information needed to construct tree
  def join_people_by_relationship_type

    sql = <<EOF
select supers.id, supers.name, subs.id, subs.name
from person_associations pa
inner join people as supers
  on supers.id = pa.source_id
inner join people as subs
  on subs.id = pa.sink_id
and association_type = 'direct_reporting'
order by supers.id
EOF

    r = ActiveRecord::Base.connection.execute(sql)
  end

  # place SQL results into a hashkeyed off of supervisor ids, pointing to a list of subordinates for that supervisor
  def build_adjacency_list

    r = join_people_by_relationship_type

    h = {}
    r.each {|rr|
      id = rr[0]
      h[id] = {:id => id, :name => rr[1], :children => []} if h[id].nil?   # if there's no hash entry for this person, make one.
      h[id][:children] << {:id => rr[2], :name => rr[3], :children => []}  # enter the person's subordinates as children into the hash. (source / sink)
    }
    h
  end

end
