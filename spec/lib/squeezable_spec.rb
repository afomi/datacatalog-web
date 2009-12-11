require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Squeezable do
  
  it "should remove adjacent duplicates" do
    a = [1, nil, nil, 10, 11, 12, nil, nil, 20]
    a.extend(Squeezable)
    expected = [1, nil, 10, 11, 12, nil, 20]
    a.squeeze.should == expected
  end
  
end
