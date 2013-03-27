require 'singleton'
require 'graphviz'

class OrgChart
  include Singleton

  def generate_org_context_svg_xml(person_id, max_sink_depth=2, mime_type)

    start = Time.now.to_f

    g = GraphViz.digraph(:G, :splines => :curved)
    g[:rankdir] = "LR"

    g.node[:color]    = "#ddaa66"
    g.node[:style]    = "filled"
    g.node[:style]    = "rounded, filled"
    g.node[:shape]    = "box"
    g.node[:penwidth] = "1"
    g.node[:fontname] = "Arial"
    g.node[:fontsize] = "10"
    g.node[:fillcolor]= "#ffeecc"
    g.node[:fontcolor]= "#775500"
    g.node[:margin]   = "0.1"

    g.edge[:color]    = "#999999"
    g.edge[:weight]   = "1"
    g.edge[:fontsize] = "6"
    g.edge[:fontcolor]= "#444444"
    g.edge[:fontname] = "Verdana"
    g.edge[:dir]      = "forward"
    g.edge[:arrowsize]= "0.5"

    p = Person.find(person_id)

    g.add_nodes(p.id.to_s, :label => p.name).fillcolor("darkseagreen1")

    rec_sources(g, p, 2)
    rec_sinks(g, p, max_sink_depth)

    if mime_type == 'svg'
      svg_xml = g.output( :svg => String )
    elsif mime_type == 'png'
      svg_xml = g.output( :png => String )
    end
    Rails.logger.info "Time to generate org chart: #{Time.now.to_f - start}"

    svg_xml
  end

  private

  def rec_sources(g, subject, max_depth, current_depth=0, nodes={}, edges={}, subgraphs={})
    current_depth = current_depth + 1
    id = subject.id.to_s
    return if current_depth == max_depth
    (nodes[id] = g.add_nodes(id,
        :label => get_node_label(subject),
        :URL => Rails.application.routes.url_helpers.person_path(:id => id),
        :target => "_parent"
        )) if !nodes.has_key?(id)
    subject.source_associations.each {|sa|
      sa_id = sa.source.id.to_s
      next if edges.has_key?([ nodes[sa_id], nodes[id] ])
      nodes[sa_id] = g.add_nodes(
        sa_id,
        :label => get_node_label(sa.source),
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

  def get_node_label(person)
label = <<EOF
#{person.name}
#{person.title}
EOF
  end

  def rec_sinks(g, subject, max_depth, current_depth=0, nodes={}, edges={}, subgraphs={})
    current_depth = current_depth + 1
    id = subject.id.to_s
    return if current_depth == max_depth
    nodes[id] = g.add_nodes(id,
      :label => get_node_label(subject),
      :URL => Rails.application.routes.url_helpers.person_path(:id => id),
      :target => "_parent"
      ) if !nodes.has_key?(id)
    subject.sink_associations.each {|sa|
      sa_id = sa.sink.id.to_s
      next if edges.has_key?([ nodes[id], nodes[sa_id] ])
      nodes[sa_id] = g.add_nodes(
        sa_id,
        :label => get_node_label(sa.sink),
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

  def get_node_color(person)
    return :lightgray if person.hiring_status == 'open'
    return :wheat if person.person_type == 'contractor'
    return :snow
  end

  def get_edge_style(association_type)
    case association_type
    when 'direct_reporting'
      style = :solid
    when 'dotted_reporting'
      style = :dashed
    else
      style = :bold
    end
    style
  end


end
