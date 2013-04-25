require 'singleton'
require 'graphviz'

class OrgChart
  include Singleton

  def generate_org_context_svg_xml(person_id, max_sink_depth=2, mime_type, paper_choice)

    start = Time.now.to_f

    # scale one page letter
    top_margin = 1.0 * 2
    side_margin = 0.5 * 2
    paper = {
      'letter_portrait'  => [8.5, 11.0],
      'legal_portrait'   => [8.5, 14.0],
      'a3_portrait'      => [11.69, 16.54],
      'letter_landscape' => [11.0, 8.5],
      'legal_landscape'  => [14.0, 8.5],
      'a3_landscape'     => [16.54, 11.69],
      'none'             => [1550, 50]
    }

    Rails.logger.info "paper choice: #{paper_choice}"
    if !paper_choice.nil? # print view
      graph_size = "#{paper[paper_choice][0] - side_margin}, #{paper[paper_choice][1] - top_margin}!"
    else # screen view
      graph_size = "#{paper['none'][0] }, #{ (1 * paper['none'][1] * (Math.log(max_sink_depth))).to_i}"
    end
    Rails.logger.info "graph size: #{graph_size}"

    g = GraphViz.digraph(:G,
      :splines => :curved,
      :size => graph_size
      )

    g[:rankdir] = "LR"
    g[:fontname]      = "Arial"
    g[:fontsize]      = "17"
    g[:labeljust]     = "l"
    g[:labelloc]      = "t"
    g[:bgcolor]       ="transparent"

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
    g[:label]         = "Org Chart | #{p.name}"

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
        :URL => Rails.application.routes.url_helpers.chart_org_context_path(:id => id),
        :target => "_parent"
        )) if !nodes.has_key?(id)
    subject.source_associations.each {|sa|
      sa_id = sa.source.id.to_s
      next if edges.has_key?([ nodes[sa_id], nodes[id] ]) || sa.association_type == 'customer_reporting'
      nodes[sa_id] = g.add_nodes(
        sa_id,
        :label => get_node_label(sa.source),
        :color => get_node_color(sa.source, :color),
        :fillcolor => get_node_color(sa.source, :fillcolor),
        :fontcolor => get_node_color(sa.source, :fontcolor),
        :URL => Rails.application.routes.url_helpers.chart_org_context_path(:id => sa_id),
        :target => "_parent"
        ) unless nodes.has_key?(sa_id)
    }
    subject.source_associations.each {|sa|
      sa_id = sa.source.id.to_s
      next if edges.has_key?([ nodes[sa_id], nodes[id] ]) || sa.association_type == 'customer_reporting'
      edges[ [ nodes[sa_id], nodes[id] ] ] = g.add_edges(
        nodes[sa_id], nodes[id],
        :style => get_edge_style(sa.association_type),
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
      :URL => Rails.application.routes.url_helpers.chart_org_context_path(:id => id),
      :target => "_parent"
      ) if !nodes.has_key?(id)
    subject.sink_associations.each {|sa|
      sa_id = sa.sink.id.to_s
      next if edges.has_key?([ nodes[id], nodes[sa_id] ]) || sa.association_type == 'customer_reporting'
      nodes[sa_id] = g.add_nodes(
        sa_id,
        :label => get_node_label(sa.sink),
        :color => get_node_color(sa.sink, :color),
        :fillcolor => get_node_color(sa.sink, :fillcolor),
        :fontcolor => get_node_color(sa.sink, :fontcolor),
        :URL => Rails.application.routes.url_helpers.chart_org_context_path(:id => sa_id),
        :target => "_parent"
        ) unless nodes.has_key?(sa_id)
    }
    subject.sink_associations.each {|sa|
      sa_id = sa.sink.id.to_s
      next if edges.has_key?([ nodes[id], nodes[sa_id] ]) || sa.association_type == 'customer_reporting'
      edges[ [ nodes[id], nodes[sa_id] ] ] = g.add_edges(
        nodes[id], nodes[sa_id],
        :style => get_edge_style(sa.association_type),
        )
      rec_sinks(g, sa.sink, max_depth, current_depth, nodes, edges, subgraphs)
    }
  end

  def get_node_color(person, attribute)
    if attribute == :fillcolor
      return :gainsboro if person.hr_status == 'resigned'
      return :coral if person.hiring_status != 'hired'
      return :wheat if person.person_type == 'contractor'
      return :ivory
    elsif attribute == :fontcolor
      return :silver if person.hr_status == 'resigned'
      return :white if person.hiring_status != 'hired'
      return :tan if person.person_type == 'contractor'
      return :burlywood
    elsif attribute == :color
      return :silver if person.hr_status == 'resigned'
      return :darkorange if person.hiring_status != 'hired'
      return :burlywood if person.person_type == 'contractor'
      return :burlywood
    end
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
