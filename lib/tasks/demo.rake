namespace :demo do
  
  def clean_slate

    DataCatalog::User.all.each do |u|
      DataCatalog::User.destroy(u.id) unless u.name == "Primary Admin"
    end

    classes = [DataCatalog::Source, DataCatalog::Organization]
    classes.each do |class_constant|
      class_constant.all.each do |instance|
        class_constant.destroy(instance.id)
      end
    end

  end
  
  def set_up_api
    dc_config = YAML.load_file(File.dirname(__FILE__) + "/../../config/api.yml")

    DataCatalog.api_key = dc_config[RAILS_ENV]['api_key']
    DataCatalog.base_uri = dc_config[RAILS_ENV]['base_uri']
  end
  
  desc "Setup seed data for app demo"
  task :seed => ["db:reset"] do    
    set_up_api
    clean_slate
    
    # users
    luigi = User.create!(:display_name => 'Luigi Montanez', :email => 'luigi@sunlightfoundation.com', :password => 'demo', :password_confirmation => 'demo')
    luigi.confirm!

    david = User.create!(:display_name => 'David James', :email => 'djames@sunlightfoundation.com', :password => 'demo', :password_confirmation => 'demo')
    david.confirm!
    
    louis = User.create!(:display_name => 'Louis Brandeis', :email => 'louis@brandeis.edu', :password => 'demo', :password_confirmation => 'demo')
    louis.confirm!
    
    # submissions
    contact1 = ContactSubmission.create!(:user_id => louis.id, :comments => "Help! I lost my password.")
    contact2 = ContactSubmission.create!(:name => "Orly Taitz", :email => "orly@taitz.com", :comments => "Check his birth certificate... He's really Kanyan!")
    contact2.folder_list = ['Whacky']
    contact2.save
    
    suggestion1 = DataSuggestion.create!(:user_id => louis.id, :title => "LOUISdb API", :url => "http://www.louisdb.org/api/index.php", :comments => "Here's a great API with a wonderful name.")
    suggestion2 = DataSuggestion.create!(:name => "Jeff Corwin", :email => "jeff@corwin.com", :title => "Bat Data", :comments => "Would love to see more animal-related data.")
    suggestion2.folder_list = ['Science']
    suggestion2.save

    # organizations
    sunlight = DataCatalog::Organization.create(:name => "Sunlight Labs", :url => "http://sunlightlabs.com/", :org_type => "not-for-profit")
    
    # sources
    sl = DataCatalog::Source.create(:title => "Sunlight Labs API", :url => 'http://services.sunlightlabs.com/api/', 
                               :source_type => "api", :organization_id => sunlight.id,
                               :license => "See Website", :license_url => "http://services.sunlightlabs.com/api/",
                               :documentation_url => "http://wiki.sunlightlabs.com/Sunlight_API_Documentation", 
                               :description => "The Sunlight Labs API provides methods for obtaining basic information on Members of Congress, legislator IDs used by various websites, and lookups between places and the politicians that represent them. The primary purpose of the API is to facilitate mashups involving politicians and the various other APIs that are out there."
                               )

    cw = DataCatalog::Source.create(:title => "Capitol Words API", :url => 'http://capitolwords.org/api/', 
                               :source_type => "api", :organization_id => sunlight.id,
                               :description => "For every day Congress is in session, Capitol Words visualizes the most frequently used words in the Congressional Record, giving you an at-a-glance view of which issues lawmakers address on a daily, weekly, monthly and yearly basis. Capitol Words lets you see what are the most popular words spoken by lawmakers on the House and Senate floor."
                               )
  
    # comments
    DataCatalog.with_key(louis.api_key) do
      DataCatalog::Comment.create(:source_id => sl.id, :text => "This is a great API!")
    end

    DataCatalog.with_key(david.api_key) do
      DataCatalog::Comment.create(:source_id => sl.id, :text => "Had some issues with the XML version...")
    end

  end
  
end