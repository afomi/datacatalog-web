require File.dirname(__FILE__) + '/spec_helper'
include DataCatalog

describe DataCatalog do

  describe ".about" do
    before do
      setup_api
    end

    it "should return information about the API" do
      about = About.get
      about.should be_an_instance_of(About)
      about.name.should == "National Data Catalog API"
      about.project_page.should == {
        "href" => "http://sunlightlabs.com/projects/datacatalog/"
      }
    end
  end

end
