class RadsController < ApplicationController
  def rads_click_to
    redirect_to rads_url(params[:id])
  end
  
  def view_banner
    @banner_id = params[:id]
  end
  
  def delete_banner
    delete_rads_banner(params[:id])
    render :text => "Banner Deleted"
  end
  
  def delete_campaign
    delete_rads_campaign(params[:id])
    render :text => "Campaign Deleted"
  end
end
