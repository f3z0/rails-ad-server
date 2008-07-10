module ViewHelpers
  def show_rads_banner(banner_type)
    banner_type = RadsBannerType.find_by_name(banner_type.to_s)
    if banner_type
      campaigns = RadsCampaign.find(:all, :include => "rads_banners", :conditions => ["rads_banners.rads_banner_type_id = ?", banner_type.id])
      total_budget = 0
      campaigns.each{ |campaign|
        total_budget += campaign.budget_remaining
      }
      campaign_fortune = {}
      i = 0
      campaigns.each{ |campaign|
        if campaign.budget_remaining > 0
          lower = i = i + 1 #increment by one to prevent overlap
          upper = i = ((campaign.budget_remaining.to_f/total_budget.to_f) * 100000) + i
          range = lower..upper
          campaign_fortune[range] = campaign
        end
      }
      random = rand(100000)
      campaign = nil
      campaign_fortune.each { |k,v|
        if k.include?(random)
          campaign = v
          break
        end
      }
      unless campaign.nil?
        banner = campaign.banner(banner_type.id)
        if banner and banner.image
          return link_to(image_tag(banner.image), :controller => "rads", :action => "rads_click_to", :id => banner.id)
        elsif banner and banner.html
          return banner.html
        end
      end
    end
    return  link_to image_tag("/images/rads/advertise_here.gif"), "/advertise"
  end

  def show_rads_panel(campaign_id)
    campaign = RadsCampaign.find(campaign_id)
    out = "<div id=\"rads_campaign_panel\"><b>#{campaign.name}</b> (Budget: $#{campaign.budget}, Remaining: $#{campaign.budget_remaining})<br/>"
    out += "<table border=\"0\"><tr><td>Banner Name</td><td>Impressions</td><td>Clicks</td><td>Actions</td></tr>" if campaign.rads_banners.length > 0
    campaign.rads_banners.each{ |banner|
      impressions = 0
      clicks = 0
      banner.rads_banner_stats.each{ |stats| #this adds up all the impressions and clicks for all the months recorded
        impressions += stats.impressions
        clicks += stats.clicks
      }
      out += "<tr><td>#{banner.name}</td><td>#{impressions}</td><td>#{clicks}</td><td>#{link_to "View Banner", :controller => "rads", :action => "view_banner", :id => banner.id}</td></tr>"
    }
    out += "</table>" if campaign.rads_banners.length > 0
    out += "</div>"
    return out
  end
  
  def show_rads_admin_panel(campaign_id)
    campaign = RadsCampaign.find(campaign_id)
    out = "<div id=\"rads_campaign_panel\"><b>#{campaign.name}</b> (Budget: $#{campaign.budget}, Remaining: $#{campaign.budget_remaining}) #{link_to "Delete Campaign", :controller => "rads", :action => "delete_campaign", :id => campaign.id}<br/>"
    out += "<table border=\"0\"><tr><td>Banner Name</td><td>Impressions</td><td>Clicks</td><td>Actions</td></tr>" if campaign.rads_banners.length > 0
    campaign.rads_banners.each{ |banner|
      impressions = 0
      clicks = 0
      banner.rads_banner_stats.each{ |stats| #this adds up all the impressions and clicks for all the months recorded
        impressions += stats.impressions
        clicks += stats.clicks
      }
      out += "<tr><td>#{banner.name}</td><td>#{impressions}</td><td>#{clicks}</td><td>#{link_to "View Banner", :controller => "rads", :action => "view_banner", :id => banner.id} | #{link_to "Delete Banner", :controller => "rads", :action => "delete_banner", :id => banner.id}</td></tr>"
    }
    out += "</table>" if campaign.rads_banners.length > 0
    out += "</div>"
    return out
  end

  def show_rads_banner_html(banner_id)
    banner = RadsBanner.find(banner_id)
    if banner and banner.image
      return "<img src=\"#{banner.image}\">"
    elsif banner and banner.html
      return banner.html
    else
      return "Banner not found."
    end
  end
end
