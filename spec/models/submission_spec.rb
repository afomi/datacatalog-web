require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Submission do

  it "should not save when missing user_id and name" do
    s = Submission.new(:email => 'foo@dot.com')
    s.save.should be(false)
    s.errors["base"].should eql("Your name and email are required")
  end

  it "should not save when missing user_id and email" do
    s = Submission.new(:name => 'John Folsom')
    s.save.should be(false)
    s.errors["base"].should eql("Your name and email are required")
  end

  it "should not save when missing user_id and name and email" do
    s = Submission.new
    s.save.should be(false)
    s.errors["base"].should eql("Your name and email are required")
  end

  it "should save when user_id is given" do
    user = User.create!(valid_user_attributes)
    s = Submission.new(:user_id => user.id)
    s.save.should be(true)
  end

  it "should save when missing user_id but name and email are given" do
    s = Submission.new(:email => 'foo@dot.com', :name => 'John Folsom')
    s.save.should be(true)
  end

  it "should set status as 'Unread' after creation" do
    user = User.create!(valid_user_attributes)
    s = Submission.new(:user_id => user.id)
    s.save

    s.status.should eql("Unread")
  end

end
