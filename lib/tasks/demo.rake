namespace :demo do
  
  def clean_slate

    DataCatalog::User.all.each do |u|
      DataCatalog::User.destroy(u.id) unless u.name =~ /(Primary Admin|Luigi Montanez|David James)/
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

    sld = DataCatalog::Source.create(:title => "Sunlight Labs Legislator Data", :url => 'http://github.com/sunlightlabs/apidata/tree/master/legislators/', 
                               :source_type => "dataset", :organization_id => sunlight.id,
                               :description => "Repository for collaborative editing of Sunlight Labs API data."
                               )
                               
    csv = DataCatalog::Download.create(:url => "http://github.com/sunlightlabs/apidata/blob/master/legislators/legislators.csv",
                                       :format => "CSV", :source_id => sld.id,
                                       :preview => %{"title","firstname","middlename","lastname","name_suffix","nickname","party","state","district","in_office","gender","phone","fax","website","webform","email","congress_office","bioguide_id","votesmart_id","fec_id","govtrack_id","crp_id","eventful_id","twitter_id","congresspedia_url","youtube_url","official_rss","senate_class","birthdate"
"Rep","Neil","","Abercrombie","","","D","HI","1","1","M","202-225-2726","202-225-4580","http://www.house.gov/abercrombie/","http://www.house.gov/abercrombie/e_form.shtml","Neil.Abercrombie@mail.house.gov","1502 Longworth House Office Building","A000014","26827","H6HI01121","400001","N00007665","P0-001-000016130-0","neilabercrombie","http://www.opencongress.org/wiki/Neil_Abercrombie","http://www.youtube.com/hawaiirep1","http://www.house.gov/apps/list/press/hi01_abercrombie/RSS.xml","","06/26/1938"
"Rep","Gary","L.","Ackerman","","","D","NY","5","1","M","202-225-2601","202-225-1589","http://ackerman.house.gov/index.html","http://www.house.gov/writerep","","2243 Rayburn House Office Building","A000022","26970","H4NY07011","400003","N00001143","P0-001-000016131-9","","http://www.opencongress.org/wiki/Gary_Ackerman","http://www.youtube.com/RepAckerman","http://www.house.gov/apps/list/press/ny05_ackerman/RSS.xml","","11/19/1942"
"Rep","Robert","B.","Aderholt","","","R","AL","4","1","M","202-225-4876","202-225-5587","http://aderholt.house.gov/index.html","http://aderholt.house.gov/?sectionid=195&sectiontree=195","","1433 Longworth House Office Building","A000055","441","H6AL04098","400004","N00003028","P0-001-000016132-8","Robert_Aderholt","http://www.opencongress.org/wiki/Robert_Aderholt","http://www.youtube.com/RobertAderholt","http://aderholt.house.gov/","","07/22/1965"})

    # comments
    DataCatalog.with_key(louis.api_key) do
      c1 = DataCatalog::Comment.create(:source_id => sl.id, :text => "This is a great API!")

      DataCatalog.with_key(david.api_key) do
        c2 = DataCatalog::Comment.create(:parent_id => c1.id, :source_id => sl.id, :text => "Disagree... Had some issues with the XML version...")
      end
      
      DataCatalog.with_key(luigi.api_key) do
        c3 = DataCatalog::Comment.create(:source_id => sl.id, :text => "Yeah, it rocks.")
        
        DataCatalog.with_key(david.api_key) do
          c4 = DataCatalog::Comment.create(:parent_id => c3.id, :source_id => sl.id, :text => "No, it doesn't!")
          
          DataCatalog.with_key(louis.api_key) do
            c5 = DataCatalog::Comment.create(:parent_id => c4.id, :source_id => sl.id, :text => "Nice argumentation there, bud.")
          end
        end
      end
    end
    
    # download

  end
  
end