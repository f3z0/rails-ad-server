class RadsGenGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.template 'lib/rads_controller.rb', 'app/controllers/rads_controller.rb'
      m.directory 'app/views/rads'
      m.file 'lib/view_banner.rhtml', 'app/views/rads/view_banner.rhtml'
      m.migration_template 'lib/radsmigration.rb',"db/migrate", :migration_file_name => "create_rads_tables"
    end
  end
end