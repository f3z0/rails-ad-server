module Rads
  class RadsCampaign < ActiveRecord::Base
    has_many :rads_banners
    
    def banner(banner_type_id)
      banner = self.rads_banners.find(:first, :order => 'RAND()', :conditions => ["rads_banner_type_id = ?", banner_type_id])
      if banner
        stats = banner.rads_banner_stats.find(:first, :conditions => ["MONTH(created_at) = ? and YEAR(created_at) = ?", Time.now.month, Time.now.year])
        stats = banner.rads_banner_stats.new if stats.nil?
        stats.impressions += 1
        stats.save
        return banner
      else
        return nil
      end
    end
    
    def budget_remaining
      budget_used = 0
      self.rads_banners.each{ |banner|
        stats = banner.rads_banner_stats.find(:first, :conditions => ["MONTH(created_at) = ? and YEAR(created_at) = ?", Time.now.month, Time.now.year])
        budget_used += stats.impressions * (banner.cpm.to_f / 1000.to_f) if stats
      }
      return budget - budget_used
    end
    
    def self.reloadable?
      false
    end
  end
end