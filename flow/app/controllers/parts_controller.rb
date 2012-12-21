class PartsController < ApplicationController

  def create
    @widget = Widget.find(params[:widget_id])
    @part = @widget.parts.create(params[:part]) # automatically associates the two
    redirect_to widget_path(@widget)
  end
  
end
