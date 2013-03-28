class ChartController < ApplicationController

  def org_context

    max_sink_depth = params[:max_sink_depth].nil? ? 2 : params[:max_sink_depth].to_i

    if params[:increase_max_sink_depth]
      max_sink_depth += 1 if max_sink_depth < 10
    end

    if params[:decrease_max_sink_depth]
      max_sink_depth -= 1 if max_sink_depth > 1
    end

    @person = Person.find(params[:id])
    @max_sink_depth = max_sink_depth

    respond_to do |format|
      format.html { render :layout => 'full_screen' }
      format.svg {
        @svg_xml = OrgChart.instance.generate_org_context_svg_xml(params[:id], max_sink_depth.to_i, 'svg', params[:paper_choice])
        render :xml => @svg_xml
      }
      #format.png {
      #  @svg_xml = OrgChart.instance.generate_org_context_svg_xml(params[:id], max_sink_depth.to_i, 'png')
      #  send_data @svg_xml, :type => 'image/png', :disposition => 'inline'
      #}
    end
  end

  def org_context_print
    max_sink_depth = params[:max_sink_depth].nil? ? 2 : params[:max_sink_depth].to_i

    @person = Person.find(params[:id])
    @max_sink_depth = max_sink_depth

    respond_to do |format|
      format.html { render :layout => 'print_screen' }
    end
  end

end
