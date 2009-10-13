# == Schema Information
#
# Table name: submissions
#
#  id         :integer(4)      not null, primary key
#  type       :string(255)
#  name       :string(255)
#  email      :string(255)
#  user_id    :integer(4)
#  title      :string(255)
#  url        :string(255)
#  comments   :text
#  created_at :datetime
#  updated_at :datetime
#  status     :string(255)
#

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
  
end
