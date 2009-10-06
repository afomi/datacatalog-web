require File.dirname(__FILE__) + '/spec_helper'

describe DataCatalog do

  describe "module accessors" do

    it "should access the API Key" do
      DataCatalog.api_key = 'flurfeneugen'
      DataCatalog.api_key.should == 'flurfeneugen'
    end

    it "should access the base URI" do
      DataCatalog.base_uri = 'somehost.com'
      DataCatalog.base_uri.should == 'somehost.com'
    end
  
  end # describe "accessors"

  describe ".with_key" do
    
    it "should set the API key within the block" do
      DataCatalog.api_key = 'flurfeneugen'
      temp_value = 'not_temp_key'
      
      DataCatalog.with_key('temp_key') do
        temp_value = DataCatalog.api_key
      end
      
      temp_value.should == 'temp_key'
      DataCatalog.api_key.should == 'flurfeneugen'
    end
    
  end # describe ".with_key"
  
end # describe DataCatalog

describe DataCatalog::Base do

  before(:each) { setup_api }

  describe ".set_base_uri" do

    it "should set and normalize the base URI" do
      DataCatalog.base_uri = 'notherhost.com'
      DataCatalog::Base.set_base_uri
      DataCatalog::Base.default_options[:base_uri].should == 'http://notherhost.com'
    end
    
    it "should set the base URI to the default if it's not explicitly defined" do
      DataCatalog.base_uri = nil
      DataCatalog::Base.set_base_uri
      DataCatalog::Base.default_options[:base_uri].should == 'http://api.nationaldatacatalog.com'
    end
  
  end # describe ".set_base_uri"
  
  describe ".set_api_key" do

    it "should set the API key" do
      DataCatalog.api_key = 'flurfeneugen'
      DataCatalog::Base.set_api_key
      DataCatalog::Base.default_options[:default_params].should include(:api_key => 'flurfeneugen')
    end

    it "should raise exception when attempting to set the API key but none is set" do
      DataCatalog.api_key = nil
      executing do
        DataCatalog::Base.set_api_key
      end.should raise_error(DataCatalog::ApiKeyNotConfigured)
    end
    
  end # describe ".set_default_params"

  describe ".set_up!" do
    
    it "should set both the base URI and API key" do
      DataCatalog.base_uri = 'somehost.com'
      DataCatalog.api_key = 'flurfeneugen'
      DataCatalog::Base.set_up!
      DataCatalog::Base.default_options[:base_uri].should == 'http://somehost.com'
      DataCatalog::Base.default_options[:default_params].should include(:api_key => 'flurfeneugen')
    end
    
  end # describe ".set_up!"
  
  describe ".build_object" do
    
    it "should create an object when a filled hash is passed in" do
      base_object = DataCatalog::Base.build_object(:name => "John Smith", :email => "john@email.com")
      base_object.should be_an_instance_of(DataCatalog::Base)
      base_object.email.should == "john@email.com"
    end
    
    it "should return nil when an empty hash is passed in" do
      base_object = DataCatalog::Base.build_object({})
      base_object.should be_nil
    end
    
    it "should return nil when nil is passed in" do
      base_object = DataCatalog::Base.build_object(nil)
      base_object.should be_nil
    end
    
  end # describe ".build_object!"

  describe ".about" do

    it "should return information about the API" do
      base_object = DataCatalog::Base.about
      base_object.should be_an_instance_of(DataCatalog::Base)
      base_object.name.should == "National Data Catalog API"
    end

  end # describe ".about"
  
  describe ".check_status_code" do
    
    it "should return nil on 200 OK" do
      response = HTTParty::Response.new(nil, '{"foo":"bar"}', 200, 'OK', {})
      DataCatalog::Base.check_status_code(response).should be_nil
    end
    
    it "should raise BadRequest on 400 Bad Request" do
      response = HTTParty::Response.new(nil, '[]', 400, 'Bad Request', {})
      executing do
        DataCatalog::Base.check_status_code(response)
      end.should raise_error(DataCatalog::BadRequest)
    end

    it "should raise Unauthorized on 401 Unauthorized" do
      response = HTTParty::Response.new(nil, '', 401, 'Unauthorized', {})
      executing do
        DataCatalog::Base.check_status_code(response)
      end.should raise_error(DataCatalog::Unauthorized)
    end

    it "should raise NotFound on 404 Not Found" do
      response = HTTParty::Response.new(nil, '[]', 404, 'Not Found', {})
      executing do
        DataCatalog::Base.check_status_code(response)
      end.should raise_error(DataCatalog::NotFound)
    end
    
    it "should raise InternalServerError on 500 Internal Server Error" do
      response = HTTParty::Response.new(nil, '', 500, 'Internal Server Error', {})
      executing do
        DataCatalog::Base.check_status_code(response)
      end.should raise_error(DataCatalog::InternalServerError)
    end
        
  end # describe ".check_status_code"
  
  describe ".error_message" do
    
    it "should return an 'Unable to parse:' message when body is blank" do
      response = HTTParty::Response.new(nil, '', 404, 'Not Found', {})
      DataCatalog::Base.error_message(response).should == %(Unable to parse: "")
    end
    
    it "should return 'Response was empty' when body is an empty JSON object" do
      response = HTTParty::Response.new(nil, '{}', 404, 'Not Found', {})
      DataCatalog::Base.error_message(response).should == "Response was empty"
    end
    
    it "should return 'Response was empty' when body is an empty array" do
      response = HTTParty::Response.new(nil, '[]', 404, 'Not Found', {})
      DataCatalog::Base.error_message(response).should == "Response was empty"
    end
    
    it "should return the contents of the errors hash when it exists" do
      errors = '{"errors":["bad_error"]}'
      response = HTTParty::Response.new(nil, errors, 400, 'Bad Request', {})
      DataCatalog::Base.error_message(response).should == '["bad_error"]'
    end
    
    it "should return the contents of the response body when no errors hash exists" do
      errors = '{"foo":["bar"]}'
      response = HTTParty::Response.new(nil, errors, 400, 'Bad Request', {})
      DataCatalog::Base.error_message(response).should == '{"foo":["bar"]}'
    end

  end # describe ".error_message"

end # describe DataCatalog::Base
