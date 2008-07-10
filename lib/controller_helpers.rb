  module ControllerHelpers
    def rads_url(banner_id)
      banner = RadsBanner.find(banner_id)
      banner.rads_banner_stats[0].clicks += 1
      banner.rads_banner_stats[0].save
      return banner.url
    end
    
    def create_rads_campaign(name, budget)
      campaign = RadsCampaign.create(:name => name, :budget => budget)
      return campaign.id
    end
    
    def create_rads_banner(name, image, type, url, campaign_id)
      banner = RadsBanner.create(:name => name, :image => image, :rads_banner_type_id => type, :url => url, :rads_campaign_id => campaign_id)
      return banner.id
    end
    
    def delete_rads_banner(id)
      RadsBanner.delete(id)
    end
    
    def delete_rads_campaign(id)
      RadsCampaign.delete(id)
    end
end