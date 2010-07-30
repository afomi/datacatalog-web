require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DataSuggestion do

  it "should set folder as 'Inbox' after creation" do
    user = User.create!(valid_user_attributes)
    s = DataSuggestion.new(:user_id => user.id, :comments => "Some comment.")
    s.save!

    s.folder_list.length.should eql(1)
    s.folder_list.first.should eql("Inbox")
  end

end
