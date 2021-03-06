require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    clean_slate
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
      @user.create_api_user
      @user.api_user.should be_an_instance_of(DataCatalog::User)
      @user.api_user.name.should eql(valid_user_attributes[:display_name])
    end

    it "should use an existing user if it exists in the API" do
      # test this using the existing API user generated
      # by rake db:ensure_admin on API instance
      @user.email = "admin@nationaldatacatalog.com"
      @user.save
      @user.create_api_user
      @user.api_user.admin.should be true
    end

  end # describe "#create_api_user"

  describe "#save" do

    it "should sync up the api_user object" do
      @user.create_api_user
      @user.api_user.name.should eql(valid_user_attributes[:display_name])
      @user.api_user.admin.should be false

      new_name = "Sam Snead"
      @user.display_name = new_name
      @user.curator = true
      @user.save
      @user.api_user.name.should eql(new_name)
      @user.api_user.curator.should be true
      @user.curator?.should be true
    end

  end # describe "#save"

  describe ".curators" do

    it "should return a collection of curator users" do
      u1 = User.create!(valid_user_attributes({:display_name => "User One", :email => "user@one.com"}))
      u2 = User.create!(valid_user_attributes({:display_name => "User Two", :email => "user@two.com"}))
      [@user, u1, u2].each { |u| u.confirm! }
      User.curators.should be_empty

      u1.curator = true
      u1.save
      User.curators.first.display_name.should eql("User One")
    end

  end # describe ".curators"

  describe ".admins" do

    it "should return a collection of admin users" do
      u1 = User.create!(valid_user_attributes({:display_name => "User One", :email => "user@one.com"}))
      u2 = User.create!(valid_user_attributes({:display_name => "User Two", :email => "user@two.com"}))
      [@user, u1, u2].each { |u| u.confirm! }
      User.admins.should be_empty

      # mock because the API does not expose admin=
      mock(u1).admin? {true}
      mock(User).all { [@user, u1, u2] }
      User.admins.first.display_name.should eql("User One")
    end

  end # describe ".admins"

end
