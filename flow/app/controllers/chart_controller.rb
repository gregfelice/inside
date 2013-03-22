class ChartController < ApplicationController

  def org_context
    person_id = params[:id]                  #2942 # marc for starters
    @person = Person.find(person_id)
    logger.info "PERSONID #{person_id}"
    max_depth = 2
    @svg_xml = OrgChart.instance.generate_org_context_svg_xml(person_id, max_depth)
    respond_to do |format|
      format.html { render :layout => 'full_screen' }
      format.svg { render :xml => @svg_xml }
    end
  end

end
