require 'singleton'
require 'graphviz'
require 'graphviz/theory'

# unflattening strategies: http://stackoverflow.com/questions/11134946/nodes-y-various-lines
class OrgChart
  include Singleton

  def initialize
  end

  # generate an org chart in the context of someone
  def generate_org_context_svg_xml(person_id, max_depth)

    start = Time.now.to_f
    g = GraphViz.digraph( :G, :splines => :curved, :ratio => :auto, :size => "11,8" )

    #g = GraphViz.digraph( :G, :splines => :curved, :use => "fdp")
    #g = GraphViz.new( :G, :type => :digraph, :splines => :ortho, :layout => :dot )
    #g[:rankdir] = "LR"

    # set global node options
    g.node[:color]    = "#ddaa66"
    g.node[:style]    = "rounded, filled"
    # g.node[:style]    = "rounded, filled"
    g.node[:shape]    = "box"
    g.node[:penwidth] = "1"
    g.node[:fontname] = "Arial"
    #g.node[:fontname] = "Trebuchet MS"
    g.node[:fontsize] = "7"
    g.node[:fillcolor]= "#ffeecc"
    g.node[:fontcolor]= "#775500"
    g.node[:margin]   = "0.1"

    # set global edge options
    g.edge[:color]    = "#999999"
    g.edge[:weight]   = "1"
    g.edge[:fontsize] = "6"
    g.edge[:fontcolor]= "#444444"
    g.edge[:fontname] = "Verdana"
    g.edge[:dir]      = "forward"
    g.edge[:arrowsize]= "0.5"

    p = Person.find(person_id)

    g.add_nodes(p.id.to_s, :label => p.name).fillcolor("darkseagreen1")

    current_depth = 0

    # TODO rec_sources(g, p, 5)
    rec_sinks(g, p, 3)

    svg_xml = g.output( :svg => String )
    Rails.logger.info "Time to generate org chart: #{Time.now.to_f - start}"

    svg_xml
  end

  private
=begin
  def rec_sources(g, node, max_depth, current_depth=0, nodes={})
    current_depth = current_depth + 1
    return if current_depth == max_depth || !nodes[node.name].nil?
    node.source_associations.each {|sa|
      style = get_style(sa.association_type)

      g.add_edges(sa.source.name, node.name).style(style)
      rec_sources(g, sa.source, max_depth, current_depth, nodes)
    }
    nodes[node.name] = node.name
  end
=end

  def rec_sources(g, subject, max_depth, current_depth=0, nodes={})
    id = subject.id.to_s
    current_depth = current_depth + 1
    return if current_depth == max_depth || !nodes[id].nil?
    nodes[id] = g.add_nodes(id, 'label' => subject.name)
    subject.source_associations.each {|sa|
      sa_id = sa.id.to_s
      nodes[sa_id] = g.add_nodes(sa_id, 'label' => sa.source.name)
      g.add_edges(nodes[sa_id], nodes[id]).style(get_style(sa.association_type))
      rec_sources(g, sa.source, max_depth, current_depth, nodes)
    }
  end


#http://techslides.com/over-1000-d3-js-examples-and-demos/
#http://bl.ocks.org/mbostock/1138500
# http://bl.ocks.org/mbostock/3311124
#http://bl.ocks.org/mbostock/4063570

  # note: we are doing this with a db recursion. expensive...
  def rec_sinks(g, subject, max_depth, current_depth=0, nodes={}, edges={})
    current_depth = current_depth + 1
    id = subject.id.to_s
    return if current_depth == max_depth
    (nodes[id] = g.add_nodes(id, 'label' => subject.name)) if !nodes.has_key?(id)


    subject.sink_associations.each {|sa|
      sa_id = sa.sink.id.to_s
      next if edges.has_key?([ nodes[id], nodes[sa_id] ])

      nodes[sa_id] = g.add_nodes(
        sa_id,
        :group => id,
        :label => sa.sink.name + "\\n" + sa.sink.title,
        :fillcolor => sa.sink.person_type == 'contractor' ? "wheat" : "snow") unless nodes.has_key?(sa_id)

      #if current_depth < 5
      #  g.add_edges(id, sa_id,
      #    :style => :invisible
      #    )
      #end


      edges[ [ nodes[id], nodes[sa_id] ] ] = g.add_edges(
        nodes[id], nodes[sa_id],
        :style => get_style(sa.association_type),
        :label => current_depth.to_s
        )

      rec_sinks(g, sa.sink, max_depth, current_depth, nodes, edges)
    }
  end

  def line_breaks(s)
    s.scan(/.*b{1}/).join("\n")
  end

  def get_style(association_type)
    case association_type
    when 'direct_reporting'
      style = :solid
    when 'dotted_reporting'
      style = :dotted
    else
      style = :bold
    end
    style
  end

end
