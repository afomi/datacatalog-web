require File.dirname(__FILE__) + '/spec_helper'

describe DataCatalog::Source do

  def create_source(params={})
    valid_params = {
      :title => "Some FCC Data",
      :url   => "http://fcc.gov/somedata.csv"
    }
    DataCatalog::Source.create(valid_params.merge(params))
  end
  
  before(:each) do
    setup_api
    clean_slate
  end

  describe ".all" do
    before do
      %w(FCC NASA DOE).each do |name|
        DataCatalog::Source.create({
          :title => "#{name} Data",
          :url   => "http://#{name.downcase}.gov/data.xml"
        })
      end
      @sources = DataCatalog::Source.all
    end
    
    it "should return an enumeration of sources" do
      @sources.each do |source|
        source.should be_an_instance_of(DataCatalog::Source)
      end
    end
    
    it "should return correct titles" do
      expected = ["FCC Data", "NASA Data", "DOE Data"]
      @sources.map(&:title).sort.should == expected.sort
    end
  end # describe ".all"
  
  describe ".create" do
    it "should create a new source from basic params" do
      source = create_source
      source.should be_an_instance_of(DataCatalog::Source)
      source.url.should == "http://fcc.gov/somedata.csv"
    end
    
    it "should create a new source from custom params" do
      source = create_source({ :custom => {
        "0" => {
          :label       => "License",
          :description => "License",
          :type        => "string",
          :value       => "Public Domain"
        }
      }})
      source.should be_an_instance_of(DataCatalog::Source)
      source.url.should == "http://fcc.gov/somedata.csv"
      source.custom.should == {
        "0" => {
          "label"       => "License",
          "description" => "License",
          "type"        => "string",
          "value"       => "Public Domain"
        }
      }
    end
  end # describe ".all"

  describe ".find" do
    before do
      @source = create_source
    end

    it "should return a source" do  
      source = DataCatalog::Source.find(@source.id)
      source.should be_an_instance_of(DataCatalog::Source)
      source.title.should == "Some FCC Data"
    end
    
    it "should raise NotFound out if no user exists" do
      executing do
        DataCatalog::Source.find(mangle(@source.id))
      end.should raise_error(DataCatalog::NotFound)
    end
  end # describe ".find"

  describe ".update" do
    before do
      @source = create_source
    end

    it "should update an existing source from valid params" do
      source = DataCatalog::Source.update(@source.id, {
        :url => "http://fec.gov/newdata.csv"
      })
      source.should be_an_instance_of(DataCatalog::Source)
      source.url.should == "http://fec.gov/newdata.csv"
    end
  end # describe ".all"  
  
  describe ".destroy" do
    before do
      @source = create_source
    end

    it "should destroy an existing source" do
      result = DataCatalog::Source.destroy(@source.id)
      result.should be_true
    end
    
    it "should raise NotFound when attempting to destroy non-existing source" do
      executing do
        DataCatalog::Source.destroy(mangle(@source.id))
      end.should raise_error(DataCatalog::NotFound)
    end
  end # describe ".destroy"
  
end
