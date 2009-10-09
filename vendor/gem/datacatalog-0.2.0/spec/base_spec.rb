require File.dirname(__FILE__) + '/spec_helper'
include DataCatalog

describe Base do

  before do
    setup_api
  end

  describe ".base_uri=" do
    it "should set and normalize the base URI" do
      setup_api
      DataCatalog.base_uri = 'host.com'
      DataCatalog.base_uri.should == 'http://host.com'
    end
    
    it "should set the base URI to the default if it's not explicitly defined" do
      DataCatalog.base_uri = ''
      DataCatalog.base_uri.should == 'http://api.nationaldatacatalog.com'
      Base.base_uri.should == 'http://api.nationaldatacatalog.com'
    end
  end

  describe ".check_status" do
    it "should return nil on 200 OK" do
      response = HTTParty::Response.new(nil, '{"foo":"bar"}', 200, 'OK', {})
      Base.check_status(response).should be_nil
    end
    
    it "should raise BadRequest on 400 Bad Request" do
      response = HTTParty::Response.new(nil, '[]', 400, 'Bad Request', {})
      executing do
        Base.check_status(response)
      end.should raise_error(BadRequest)
    end
  
    it "should raise Unauthorized on 401 Unauthorized" do
      response = HTTParty::Response.new(nil, '', 401, 'Unauthorized', {})
      executing do
        Base.check_status(response)
      end.should raise_error(Unauthorized)
    end
  
    it "should raise NotFound on 404 Not Found" do
      response = HTTParty::Response.new(nil, '[]', 404, 'Not Found', {})
      executing do
        Base.check_status(response)
      end.should raise_error(NotFound)
    end
    
    it "should raise InternalServerError on 500 Internal Server Error" do
      response = HTTParty::Response.new(nil, '', 500, 'Internal Server Error', {})
      executing do
        Base.check_status(response)
      end.should raise_error(InternalServerError)
    end
  end

  describe ".error" do
    it "should return an 'Unable to parse:' message when body is blank" do
      response = HTTParty::Response.new(nil, '', 404, 'Not Found', {})
      Base.error(response).should == %(Unable to parse: "")
    end
    
    it "should return 'Response was empty' when body is an empty JSON object" do
      response = HTTParty::Response.new(nil, '{}', 404, 'Not Found', {})
      Base.error(response).should == "Response was empty"
    end
    
    it "should return 'Response was empty' when body is an empty array" do
      response = HTTParty::Response.new(nil, '[]', 404, 'Not Found', {})
      Base.error(response).should == "Response was empty"
    end
    
    it "should return the contents of the errors hash when it exists" do
      errors = '{"errors":["bad_error"]}'
      response = HTTParty::Response.new(nil, errors, 400, 'Bad Request', {})
      Base.error(response).should == '["bad_error"]'
    end
    
    it "should return the contents of the response body when no errors hash exists" do
      errors = '{"foo":["bar"]}'
      response = HTTParty::Response.new(nil, errors, 400, 'Bad Request', {})
      Base.error(response).should == '{"foo":["bar"]}'
    end
  end

  describe ".many" do
    it "should create an object from a filled array" do
      array = Base.many([
        {
          :name  => "Carl Malamud",
          :email => "no-spam-carl@media.org"
        },
        {
          :name  => "Ellen Miller",
          :email => "no-spam-ellen@sunlightfoundation.com"
        }
      ])
      array.map do |item|
        item.should be_an_instance_of(Base)
      end
      array.map(&:name).should == ["Carl Malamud", "Ellen Miller"]
    end    
  end

  describe ".one" do
    it "should create an object from a filled hash" do
      hash = Base.one({
        :name  => "John Smith",
        :email => "john@email.com"
      })
      hash.should be_an_instance_of(Base)
      hash.name.should == "John Smith"
      hash.email.should == "john@email.com"
    end
    
    it "should return nil from an empty hash" do
      hash = Base.one({})
      hash.should be_nil
    end
    
    it "should return nil from nil" do
      hash = Base.one(nil)
      hash.should be_nil
    end
  end

end
