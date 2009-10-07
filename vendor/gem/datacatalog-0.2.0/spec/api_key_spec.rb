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
    result = user.generate_api_key!(
      :purpose  => "Civic hacking with my awesome app",
      :key_type => "application"
    )
    raise "generate_api_key! failed" unless result
    raise "incorrect number of keys" unless user.api_keys.length == 2
    user
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
end
