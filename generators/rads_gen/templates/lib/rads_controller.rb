class RadsController < ApplicationController
  def rads_click_to
    redirect_to rads_url(params[:id])
  end
  
  def view_banner
    @banner_id = params[:id]
  end
end
