class MainController < ApplicationController
  
  def dashboard
    if current_user
      @recent_comments = DataCatalog::Comment.all(:user_id => current_user.api_id)
      @recent_comments.each do |c|
        source = DataCatalog::Source.get(c.source_id)
        c.source_title = source.title
        c.source_slug = source.slug
      end

      @all_ratings = DataCatalog::Rating.all(:user_id => current_user.api_id)
      @recent_ratings = []
      @all_ratings.take(5).each do |rating|
        if rating.kind == "source"
          source = DataCatalog::Source.get(rating.source_id)
          rating.source_title = source.title
          rating.source_slug = source.slug
          @recent_ratings << rating
        end
      end
      render 'dashboard' and return
    else
      render 'welcome' and return
    end
  end
  
  def about
    
  end
  
  def blog
    require 'feedzirra'
    
    url = "http://sunlightlabs.com/blog/feeds/tag/datacatalog/" #natdatcat or data.gov
    feed = Feedzirra::Feed.fetch_and_parse(url)
    @entries = feed.entries
  end
  
  def source
    
    @source = DataCatalog::Source.get(params[:slug])
    
  end
  
  
end
