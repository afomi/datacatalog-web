require File.dirname(__FILE__) + '/spec_helper'

describe DataCatalog::User do

  def create_user
    DataCatalog::User.create({
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
  
  before(:each) do
    setup_api
    clean_slate
  end

  describe ".all" do
    before(:each) do
      3.times do |n|
        DataCatalog::User.create(
          :name  => "User-#{n}",
          :email => "user_#{n}@email.com"
        )
      end
      @users = DataCatalog::User.all
    end
    
    it "should return an enumeration of users" do
      @users.each do |u|
        u.should be_an_instance_of(DataCatalog::User)
      end
    end
    
    it "should include four users" do
      names = @users.map(&:name)
      names.should include("User-0")
      names.should include("User-1")
      names.should include("User-2")
    end
  end # describe ".all"

  describe ".create" do
    before do
      @user = create_user
    end

    it "should create a new user when valid params are passed in" do
      @user.should be_an_instance_of(DataCatalog::User)
      @user.name.should == "Ted Smith"
      @user.email.should == "ted@email.com"
    end

    it "should raise BadRequest when invalid params are passed in" do
      executing do
        DataCatalog::User.create({ :garbage_field => "junk" })
      end.should raise_error(DataCatalog::BadRequest)
    end
  end # describe ".create"
  
  describe ".find" do
    before do
      @user = create_user
    end

    it "should return a user" do  
      user = DataCatalog::User.find(@user.id)
      user.should be_an_instance_of(DataCatalog::User)
      user.email.should == "ted@email.com"
    end
    
    it "should raise NotFound out if no user exists" do
      executing do
        DataCatalog::User.find(mangle(@user.id))
      end.should raise_error(DataCatalog::NotFound)
    end
  end # describe ".find"
  
  describe ".find_by_api_key" do
    before do
      @user = create_user
    end
    
    it "should return a user" do
      user = DataCatalog::User.find_by_api_key(@user.primary_api_key)
      user.should be_an_instance_of(DataCatalog::User)
      user.email.should == "ted@email.com"
    end
  end # describe ".find_by_api_key"
    
  describe ".update" do
    before do
      @user = create_user
    end
    
    it "should update a user when valid params are passed in" do
      user = DataCatalog::User.update(@user.id, { :name => "Jane Smith" })
      user.name.should == "Jane Smith"
    end

    it "should raise BadRequest when invalid params are passed in" do
      executing do
        DataCatalog::User.update(@user.id, { :garbage => "junk" })
      end.should raise_error(DataCatalog::BadRequest)
    end

  end # describe ".update"
  
  describe ".destroy" do
    before do
      @user = create_user
    end

    it "should destroy an existing user" do
      result = DataCatalog::User.destroy(@user.id)
      result.should be_true
    end
    
    it "should raise NotFound when non-existing user" do
      executing do
        DataCatalog::User.destroy(mangle(@user.id))
      end.should raise_error(DataCatalog::NotFound)
    end
  end # describe ".destroy"

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
      end.should raise_error(DataCatalog::BadRequest)
    end
  end # describe "#generate_api_key!"
  
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
      end.should raise_error(DataCatalog::NotFound)
    end

    it "should raise BadRequest if primary key's type is changed" do
      executing do
        @user.update_api_key!(@user.api_keys[0].id, {
          :key_type => "valet"
        })
      end.should raise_error(DataCatalog::BadRequest)
    end
  end # describe "#update_api_key!"

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
      end.should raise_error(DataCatalog::Conflict)
      @user.api_keys.length.should == 2
    end
  end # describe "#delete_api_key!"
  
end
