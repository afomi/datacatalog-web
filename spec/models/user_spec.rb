require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    setup_api
    @user = User.create!(valid_user_attributes)
  end

  it "validations" do
    should validate_presence_of(:email)
  end 
    
  describe "#confirmed?" do

    it "should return false if confirmed_at is nil" do
      @user.confirmed_at = nil
      @user.confirmed?.should be(false)
    end

    it "should return false if confirmed_at is '0000-00-00 00:00:00'" do
      @user.confirmed_at = '0000-00-00 00:00:00'
      @user.confirmed?.should be(false)
    end

    it "should return true if confirmed_at is '2009-01-01 12:34:56'" do
      @user.confirmed_at = '2009-01-01 12:34:56'
      @user.confirmed?.should be(true)
    end
    
    it "should return false after initial creation" do
      @user.confirmed?.should be(false)
    end

    it "should return true after confirmation" do
      stub(@user).create_api_user
      @user.confirm!
      @user.confirmed?.should be(true)
    end
    
  end # describe "#confirmed?"
  
  describe "#confirm!" do
    
    it "should set confirmed_at to the current_time" do
      stub(@user).create_api_user
      stubbed_time = Time.now
      stub(Time).now {stubbed_time}
      @user.confirm!
      @user.confirmed_at.should == stubbed_time 
    end
    
  end # describe "#confirm!"
  
  describe "#create_api_user" do
    
    it "should set the user's api_key" do
      mock_user = DataCatalog::User.new
      mock(mock_user).primary_api_key {'jasdlkfj39'}
      stub(DataCatalog::User).create { mock_user }
      
      @user.create_api_user
      @user.api_key.should eql('jasdlkfj39')
    end
    
  end # describe "#create_api_user"
  
end
