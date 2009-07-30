require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :display_name => 'John D.',
      :email        => 'joe@test.com',
      :password     => 's3krit',
      :password_confirmation => 's3krit'
    }
    @user = User.create!(@valid_attributes)
  end

  it { should validate_presence_of(:email) }

  context "#confirmed?" do

    it "should return false after initial creation" do
      @user.confirmed?.should be(false)
    end

    it "should return true after confirmation" do
      @user.confirm!
      @user.confirmed?.should be(true)
    end
    
  end # context "#confirmed?"
  
  context "#confirm!" do
    
    it "should set confirmed_at to the current_time" do
      stubbed_time = Time.now
      stub(Time).now {stubbed_time}
      @user.confirm!
      @user.confirmed_at.should == stubbed_time 
    end
    
  end # context "#confirm!"
  
end
