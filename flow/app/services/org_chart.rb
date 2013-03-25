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
    g = GraphViz.digraph( :G, :splines => :curved, :ratio => :auto, :concentrate => true) #, :size => "10.5,8" )

    #g = GraphViz.digraph( :G, :splines => :curved, :use => "fdp")
    #g = GraphViz.new( :G, :type => :digraph, :splines => :ortho, :layout => :dot )
    g[:rankdir] = "LR"

    # set global node options
    g.node[:color]    = "#ddaa66"
    g.node[:style]    = "rounded, filled"
    # g.node[:style]    = "rounded, filled"
    g.node[:shape]    = "box"
    g.node[:penwidth] = "1"
    g.node[:fontname] = "Arial"
    #g.node[:fontname] = "Trebuchet MS"
    g.node[:fontsize] = "10"
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

    max_depth = 20
    rec_sources(g, p, max_depth)
    rec_sinks(g, p, max_depth)

    Rails.logger.info g.inspect

    svg_xml = g.output( :svg => String )
    # svg_xml = g.output( :png => "foo.png" )
    Rails.logger.info "Time to generate org chart: #{Time.now.to_f - start}"

    svg_xml
  end

  private

  def old_rec_sources(g, subject, max_depth, current_depth=0, nodes={})
    id = subject.id.to_s
    current_depth = current_depth + 1
    return if current_depth == max_depth || !nodes[id].nil?
    nodes[id] = g.add_nodes(id, 'label' => subject.name)
    subject.source_associations.each {|sa|
      sa_id = sa.id.to_s
      nodes[sa_id] = g.add_nodes(sa_id, 'label' => sa.source.name)
      g.add_edges(nodes[sa_id], nodes[id]).style(get_edge_style(sa.association_type))
      rec_sources(g, sa.source, max_depth, current_depth, nodes)
    }
  end

  # http://techslides.com/over-1000-d3-js-examples-and-demos/
  # http://bl.ocks.org/mbostock/1138500
  # http://bl.ocks.org/mbostock/3311124
  # http://bl.ocks.org/mbostock/4063570


  def get_node_color(person)
    return :lightgray if person.hiring_status == 'open'
    return :wheat if person.person_type == 'contractor'
    return :snow
  end

  def rec_sources(g, subject, max_depth, current_depth=0, nodes={}, edges={}, subgraphs={})
    current_depth = current_depth + 1
    id = subject.id.to_s
    return if current_depth == max_depth
    (nodes[id] = g.add_nodes(id,
        'label' => subject.name,
        :URL => Rails.application.routes.url_helpers.person_path(:id => id),
        :target => "_parent"
        )) if !nodes.has_key?(id)
    subject.source_associations.each {|sa|
      sa_id = sa.source.id.to_s
      next if edges.has_key?([ nodes[sa_id], nodes[id] ])
      nodes[sa_id] = g.add_nodes(
        sa_id,
        :label => sa.source.name + "\\n" + sa.source.title,
        :fillcolor => get_node_color(sa.source),
        :URL => Rails.application.routes.url_helpers.person_path(:id => sa_id),
        :target => "_parent"
        ) unless nodes.has_key?(sa_id)
    }
    subject.source_associations.each {|sa|
      sa_id = sa.source.id.to_s
      next if edges.has_key?([ nodes[sa_id], nodes[id] ])
      edges[ [ nodes[sa_id], nodes[id] ] ] = g.add_edges(
        nodes[sa_id], nodes[id],
        :style => get_edge_style(sa.association_type),
        :label => current_depth.to_s,
        :edgeURL => Rails.application.routes.url_helpers.chart_org_context_path(:id => sa_id),
        :target => "_parent"
        )
      rec_sources(g, sa.source, max_depth, current_depth, nodes, edges, subgraphs)
    }
  end


  def rec_sinks(g, subject, max_depth, current_depth=0, nodes={}, edges={}, subgraphs={})
    current_depth = current_depth + 1
    id = subject.id.to_s
    return if current_depth == max_depth
    (nodes[id] = g.add_nodes(id,
        'label' => subject.name,
        :URL => Rails.application.routes.url_helpers.person_path(:id => id),
        :target => "_parent"
        )) if !nodes.has_key?(id)
    subject.sink_associations.each {|sa|
      sa_id = sa.sink.id.to_s
      next if edges.has_key?([ nodes[id], nodes[sa_id] ])
      nodes[sa_id] = g.add_nodes(
        sa_id,
        :label => sa.sink.name + "\\n" + sa.sink.title,
        :fillcolor => get_node_color(sa.sink),
        :URL => Rails.application.routes.url_helpers.person_path(:id => sa_id),
        :target => "_parent"
        ) unless nodes.has_key?(sa_id)
    }
    subject.sink_associations.each {|sa|
      sa_id = sa.sink.id.to_s
      next if edges.has_key?([ nodes[id], nodes[sa_id] ])
      edges[ [ nodes[id], nodes[sa_id] ] ] = g.add_edges(
        nodes[id], nodes[sa_id],
        :style => get_edge_style(sa.association_type),
        :label => current_depth.to_s,
        :edgeURL => Rails.application.routes.url_helpers.chart_org_context_path(:id => sa_id),
        :target => "_parent"
        )
      rec_sinks(g, sa.sink, max_depth, current_depth, nodes, edges, subgraphs)
    }
  end


  def complex_rec_sinks(g, subject, max_depth, current_depth=0, nodes={}, edges={}, subgraphs={})
    current_depth = current_depth + 1
    id = subject.id.to_s
    return if current_depth == max_depth
    (nodes[id] = g.add_nodes(id, 'label' => subject.name)) if !nodes.has_key?(id)

    # subgraphs
    if current_depth == 2 && false
      subgraphs[id] = g.add_graph(
        "cluster_#{id}",
        :fontname => "Arial",
        :color => :lightgrey,
        #:label => "#{subject.name} Area"
        #:bgcolor => "orange",
        ) unless subgraphs.has_key?("cluster_#{id}")
      Rails.logger.info "subgraphs: #{subgraphs.size} added for key: #{id} : #{subject.name}"
      g = subgraphs[id]
      new_subgraph = true
    else
      new_subgraph = false
    end

    # real nodes
    subject.sink_associations.each {|sa|
      sa_id = sa.sink.id.to_s
      next if edges.has_key?([ nodes[id], nodes[sa_id] ])

      nodes[sa_id] = g.add_nodes(
        sa_id,
        :label => sa.sink.name + "\\n" + sa.sink.title,
        :fillcolor => get_node_color(sa.sink.person_type),
        #:URL => Rails.application.routes.url_helpers.person_path(sa_id)
        :URL => Rails.application.routes.url_helpers.chart_org_context_path(:id => sa_id),
        :target => "_parent"
        ) unless nodes.has_key?(sa_id)
    }

    # layout edges
    sink_assocs = subject.sink_associations
    i = 0
    for i in 0..sink_assocs.size
      if !sink_assocs[i].nil? && !sink_assocs[i+1].nil? && current_depth > 1 && false
        node_a_id = sink_assocs[i].sink.id.to_s
        node_b_id = sink_assocs[i+1].sink.id.to_s
        g.add_edges(node_a_id, node_b_id,
          :style => :solid,
          :color => "orchid",
          #:style => :invis,
          #:weight => 10
          )
      else
        break
      end
    end

    # real edges, and recursion
    # ltail for these people should point to the g.id
    subject.sink_associations.each {|sa|
      sa_id = sa.sink.id.to_s
      next if edges.has_key?([ nodes[id], nodes[sa_id] ])

      if true # current_depth < 2
        edges[ [ nodes[id], nodes[sa_id] ] ] = g.add_edges(
          nodes[id], nodes[sa_id],
          :style => get_edge_style(sa.association_type),
          :label => current_depth.to_s,
          :lhead => nodes[sa_id],
          :ltail => g.id,
          #:weight => -10,
          :nojustify => false,
          :len => 0.3,
          #:style => :invis
          )
      end
      rec_sinks(g, sa.sink, max_depth, current_depth, nodes, edges, subgraphs)
    }
  end



  def line_breaks(s)
    s.scan(/.*b{1}/).join("\n")
  end

  def get_edge_style(association_type)
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
