require File.dirname(__FILE__) + '/spec_helper'
include DataCatalog

module ApiKeyHelpers
  def create_user
    User.create({
      :name  => "Ted Smith",
      :email => "ted@email.com"
    })
  end
  
  def create_user_with_2_keys
    user = create_user
    ApiKey.create(user.id, {
      :purpose  => "Civic hacking",
      :key_type => "application"
    })
    User.get(user.id)
  end
end

describe ApiKey do
  include ApiKeyHelpers

  before do
    setup_api
    clean_slate
  end

  describe ".all" do
    before do
      @user = create_user_with_2_keys
      @api_keys = ApiKey.all(@user.id)
    end
  
    it "should return an enumeration of API keys" do
      @api_keys.each do |api_key|
        api_key.should be_an_instance_of(ApiKey)
      end
    end
  
    it "should return correct titles" do
      @api_keys.map(&:key_type).should == %w(primary application)
    end
  end

  describe ".all with conditions" do
    before do
      @user = create_user_with_2_keys
      @api_keys = ApiKey.all(@user.id, :key_type => "application")
    end
    
    it "should return an enumeration of API keys" do
      @api_keys.each do |api_key|
        api_key.should be_an_instance_of(ApiKey)
      end
    end
    
    it "should return correct titles" do
      @api_keys.map(&:key_type).should == %w(application)
    end
  end

  describe ".create" do
    it "should create a new API key from basic params" do
      user = create_user_with_2_keys
      api_key = ApiKey.create(user.id, {
        :purpose  => "Data wrangling",
        :key_type => "valet"
      })
      api_key.should be_an_instance_of(ApiKey)
      api_key.key_type.should == "valet"
    end
  end

  describe ".first" do
    before do
      @user = create_user_with_2_keys
    end
  
    it "should return an API key" do
      api_key = ApiKey.first(@user.id, :purpose => "Civic hacking")
      api_key.should be_an_instance_of(ApiKey)
      api_key.purpose.should == "Civic hacking"
    end
    
    it "should return nil if nothing found" do
      api_key = ApiKey.first(@user.id, :purpose => "Evil")
      api_key.should be_nil
    end
  end

  describe ".get" do
    before do
      @user = create_user_with_2_keys
      @api_key = @user.api_keys[1]
    end
  
    it "should return an API key" do
      api_key = ApiKey.get(@user.id, @api_key.id)
      api_key.should be_an_instance_of(ApiKey)
      api_key.purpose.should == "Civic hacking"
    end
    
    it "should raise NotFound if no API key exists" do
      executing do
        ApiKey.get(@user.id, mangle(@api_key.id))
      end.should raise_error(NotFound)
    end
  end

  describe ".update" do
    before do
      @user = create_user_with_2_keys
      @api_key = @user.api_keys[1]
    end
  
    it "should update an existing source from valid params" do
      api_key = ApiKey.update(@user.id, @api_key.id, {
        :purpose => "Local Government Reporting"
      })
      api_key.should be_an_instance_of(ApiKey)
      api_key.purpose.should == "Local Government Reporting"
    end
  end

  describe ".destroy" do
    before do
      @user = create_user_with_2_keys
      @api_key = @user.api_keys[1]
    end
  
    it "should destroy an existing source" do
      result = ApiKey.destroy(@user.id, @api_key.id)
      result.should be_true
    end
    
    it "should raise NotFound if API key does not exist" do
      executing do
        ApiKey.destroy(@user.id, mangle(@api_key.id))
      end.should raise_error(NotFound)
    end
  end

end
