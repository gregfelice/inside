class ChartController < ApplicationController

  def org_context

    max_sink_depth = params[:max_sink_depth].nil? ? 2 : params[:max_sink_depth].to_i
    logger.info max_sink_depth

    if params[:increase_max_sink_depth]
      max_sink_depth += 1 if max_sink_depth < 10
    end

    if params[:decrease_max_sink_depth]
      max_sink_depth -= 1 if max_sink_depth > 1
    end
    logger.info max_sink_depth

    @person = Person.find(params[:id])
    @max_sink_depth = max_sink_depth

    respond_to do |format|
      format.html {
        render :layout => 'full_screen'
      }
      format.svg {
        @svg_xml = OrgChart.instance.generate_org_context_svg_xml(params[:id], max_sink_depth.to_i)
        render :xml => @svg_xml
      }
    end
  end

end
