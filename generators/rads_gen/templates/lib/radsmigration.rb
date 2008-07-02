class CreateRadsTables < ActiveRecord::Migration
  def self.up
    create_table :rads_banner_stats do |t|
      t.column "impressions", :int, :default => 0
      t.column "clicks", :int, :default => 0
      t.column "rads_banner_id", :int
      t.timestamps
    end
    create_table :rads_banner_types do |t|
      t.column "name", :string
      t.column "cpm", :float
      t.timestamps
    end
    create_table :rads_banners do |t|
      t.column "rads_campaign_id", :int
      t.column "image", :string
      t.column "html", :text
      t.column "name", :string
      t.column "rads_banner_type_id", :int
      t.column "url", :string
      t.timestamps
    end
    create_table :rads_campaigns do |t|
      t.column "name", :string
      t.column "budget", :float
      t.timestamps
    end
  end
 
  def self.down
    drop_table rads_banner_stats
    drop_table rads_banner_types
    drop_table rads_banners
    drop_table rads_campaigns
  end
end