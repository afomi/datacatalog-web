class BrowseController < ApplicationController
  
  def index
    @sources = DataCatalog::Source.all
    @page = params[:page].nil? ? 1 : params[:page].to_i
    @pages = 1.upto(@sources.page_count).map do |i|
      { :number => i, :path => "?page=#{i}" }
    end
  end
  
end