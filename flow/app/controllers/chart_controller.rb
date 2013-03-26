class ChartController < ApplicationController

=begin

show / dont show titles

show 2 levels, 3 levels... what about more / less levels... yes.. i like that.

start with 2.

ok - so, that's a button and a saved value..

=end

  def org_context

    max_sink_depth = params[:max_sink_depth].nil? ? 2 : params[:max_sink_depth]
    @svg_xml = OrgChart.instance.generate_org_context_svg_xml(params[:id], max_sink_depth.to_i)
    @person = Person.find(params[:id])
    @max_sink_depth = params[:max_sink_depth]

    respond_to do |format|
      format.html { render :layout => 'full_screen' }
      format.svg { render :xml => @svg_xml }
    end
  end

end
