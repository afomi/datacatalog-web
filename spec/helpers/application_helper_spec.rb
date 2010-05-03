require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do

  describe "active_if" do
    it "when controller matches" do
      params[:controller] = "search"
      helper.active_if(:controller => ["search"]).should == "active"
    end

    it "when controller does not match" do
      params[:controller] = "search"
      helper.active_if(:controller => ["not_search"]).should == ""
    end

    it "when action matches" do
      params[:action] = "index"
      helper.active_if(:action => ["index"]).should == "active"
    end

    it "when action does not match" do
      params[:action] = "index"
      helper.active_if(:action => ["not_index"]).should == ""
    end
  end

end
