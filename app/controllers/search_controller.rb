class SearchController < ApplicationController

  RADIUS = 3
  
  def index
    @term = params[:term]
    @sources = @term.blank? ? [] : DataCatalog::Source.search(@term)
    @page = params[:page].nil? ? 1 : params[:page].to_i
    @pages = list_of_pages
  end

  protected
  
  def list_of_pages
    max = @sources.page_count
    list = 1.upto(max).map do |i|
      if [1, max].include?(i) || (@page - RADIUS .. @page + RADIUS) === i
        { :number => i, :path => "?page=#{i}" }
      end
    end
    list.extend(Squeezable).squeeze
  end
  
end