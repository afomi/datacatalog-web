require File.dirname(__FILE__) + '/spec_helper'
include DataCatalog

module UserHelpers
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
  
  def create_3_users
    3.times do |n|
      User.create(
        :name  => "User-#{n}",
        :email => "user_#{n}@email.com"
      )
    end
  end
end

describe User do
  include UserHelpers
  
  before do
    setup_api
    clean_slate
  end

  describe ".all" do
    before do
      create_3_users
      @users = User.all
    end
    
    it "should return an enumeration of users" do
      @users.each do |u|
        u.should be_an_instance_of(User)
      end
    end
    
    it "should include four users" do
      names = @users.map(&:name)
      names.should include("User-0")
      names.should include("User-1")
      names.should include("User-2")
    end
  end

  describe ".create" do
    before do
      @user = create_user
    end

    it "should create a new user when valid params are passed in" do
      @user.should be_an_instance_of(User)
      @user.name.should == "Ted Smith"
      @user.email.should == "ted@email.com"
    end

    it "should raise BadRequest when invalid params are passed in" do
      executing do
        User.create({ :garbage_field => "junk" })
      end.should raise_error(BadRequest)
    end
  end
  
  describe ".first" do
    before do
      create_3_users
    end

    it "should return a user" do
      user = User.first(:name => "User-1")
      user.should be_an_instance_of(User)
      user.name.should == "User-1"
    end
    
    it "should return nil if nothing found" do
      user = User.first(:name => "Elvis")
      user.should be_nil
    end
  end
  
  describe ".get_by_api_key" do
    before do
      @user = create_user
    end
    
    it "should return a user" do
      user = User.get_by_api_key(@user.primary_api_key)
      user.should be_an_instance_of(User)
      user.email.should == "ted@email.com"
    end
  end

  describe ".get" do
    before do
      @user = create_user_with_2_keys
    end
    
    describe "user exists" do
      before do
        @u = User.get(@user.id)
      end

      it "should return a user" do
        @u.should be_an_instance_of(User)
        @u.name.should == "Ted Smith"
        @u.email.should == "ted@email.com"
      end

      it "should include 2 api_keys" do
        keys = @u.api_keys
        keys.map(&:key_type).should == %w(primary application)
        keys.each do |key|
          key.should be_an_instance_of(ApiKey)
        end
      end
    end
    
    it "should raise NotFound if no user exists" do
      executing do
        User.get(mangle(@user.id))
      end.should raise_error(NotFound)
    end
  end

  describe ".get_by_api_key" do
    before do
      @user = create_user_with_2_keys
    end
    
    describe "API key exists" do
      before do
        @u = User.get_by_api_key(@user.primary_api_key)
      end

      it "should return a user" do
        @u.should be_an_instance_of(User)
        @u.name.should == "Ted Smith"
        @u.email.should == "ted@email.com"
      end

      it "should include 2 api_keys" do
        keys = @u.api_keys
        keys.map(&:key_type).should == %w(primary application)
        keys.each do |key|
          key.should be_an_instance_of(ApiKey)
        end
      end
    end

    it "should raise NotFound if API key does not exist" do
      executing do
        User.get_by_api_key(mangle(@user.primary_api_key))
      end.should raise_error(NotFound)
    end
  end

  describe ".update" do
    before do
      @user = create_user
    end
    
    it "should update a user when valid params are passed in" do
      user = User.update(@user.id, { :name => "Jane Smith" })
      user.name.should == "Jane Smith"
    end

    it "should raise BadRequest when invalid params are passed in" do
      executing do
        User.update(@user.id, { :garbage => "junk" })
      end.should raise_error(BadRequest)
    end
  end
  
  describe ".destroy" do
    before do
      @user = create_user
    end

    it "should destroy an existing user" do
      result = User.destroy(@user.id)
      result.should be_true
    end
    
    it "should raise NotFound when non-existing user" do
      executing do
        User.destroy(mangle(@user.id))
      end.should raise_error(NotFound)
    end
  end

  describe "#generate_api_key!" do
    before do
      @user = create_user
    end

    it "should generate a new key for the user" do
      @user.api_keys.length.should == 1
      @user.generate_api_key!({
        :purpose  => "Civic hacking with my awesome app",
        :key_type => "application"
      }).should be_true
      @user.api_keys.length.should == 2
      @user.api_keys.last[:purpose].should == "Civic hacking with my awesome app"
      @user.application_api_keys.length.should == 1
    end
    
    it "should raise BadRequest when attempting to create a primary key" do
      executing do
        @user.generate_api_key!({
          :purpose  => "Civic hacking with my awesome app",
          :key_type => "primary"
        })
      end.should raise_error(BadRequest)
    end
  end
  
  describe "#update_api_key!" do
    before do
      @user = create_user_with_2_keys
    end
  
    it "should update a key for the user" do
      @user.update_api_key!(@user.api_keys[1].id, {
        :key_type => "valet",
        :purpose  => "To be more awesome"
      }).should be_true
      @user.api_keys[1].purpose.should == "To be more awesome"
    end
    
    it "should raise NotFound if updating a key that doesn't exist" do
      executing do
        @user.update_api_key!(mangle(@user.api_keys[1].id), {})
      end.should raise_error(NotFound)
    end

    it "should raise BadRequest if primary key's type is changed" do
      executing do
        @user.update_api_key!(@user.api_keys[0].id, {
          :key_type => "valet"
        })
      end.should raise_error(BadRequest)
    end
  end

  describe "#delete_api_key!" do
    before do
      @user = create_user_with_2_keys
    end
    
    it "should delete a key for the user" do
      @user.delete_api_key!(@user.api_keys[1].id).should be_true
      @user.api_keys.length.should == 1
    end
    
    it "should raise Conflict if deleting the primary key" do
      executing do
        @user.delete_api_key!(@user.api_keys[0].id)
      end.should raise_error(Conflict)
      @user.api_keys.length.should == 2
    end
  end
  
end
