class DataController < ApplicationController
  
  before_filter :set_source
  
  def show
    
    @is_favorite = false
    current_user.api_user.favorites.each do |source|
      @is_favorite = true if source.slug == params[:slug]
    end
    
    @comment = DataCatalog::Comment.new
    @comments = []
    @source.comments.each do |comment|
      comment.id = extract_id(comment.href)
      comment.children = []
      comment.user = User.find_by_api_id(extract_id(comment.user.href))
      if comment.parent
        parent = find_parent_comment(@comments, comment.parent.id)
        parent.children << comment
      else
        @comments << comment
      end
    end
    
    @parent_id = params[:parent_id]
    @reports_problem = params[:reports_problem]
  end
  
  def comment
    comment = params[:data_catalog_comment]
    DataCatalog.with_key(current_user.api_key) do
      api_params = { :source_id => @source.id, :text => comment[:text] }
      [:parent_id, :reports_problem].each do |field|
        api_params[field] = comment[field]  if comment[field] && !comment[field].blank?
      end
      DataCatalog::Comment.create(api_params)
    end
    flash[:notice] = "Comment saved!"
    redirect_to source_path(@source.slug)
  end
  
  def rating
    DataCatalog.with_key(current_user.api_key) do
      DataCatalog::Rating.create(:kind => "source", :source_id => @source.id, :value => params[:value])
    end
    flash[:notice] = "Rating saved!"
    redirect_to source_path(@source.slug)
  end
  
  def comment_rating
    DataCatalog.with_key(current_user.api_key) do
      DataCatalog::Rating.create(:kind => "comment", :comment_id => params[:comment_id], :value => 1)
    end
    flash[:notice] = "Comment rating saved!"
    redirect_to source_path(@source.slug)
  end    
  
  def favorite
    DataCatalog.with_key(current_user.api_key) do
     DataCatalog::Favorite.create(:source_id => @source.id)
    end
    flash[:notice] = "Added as favorite!"
    redirect_to source_path(@source.slug)
  end
  
  def unfavorite
    DataCatalog.with_key(current_user.api_key) do
     DataCatalog::Favorite.all(:source_id => @source.id).each do |f|
       DataCatalog::Favorite.destroy(f.id) if f.user_id == current_user.api_id
      end
    end
    flash[:notice] = "Removed favorite."
    redirect_to source_path(@source.slug)
  end
  
  private
  
  def find_parent_comment(comments, parent_id)
    comments.each do |comment|
      return comment if comment.id == parent_id
    end
    
    parent = nil
    comments.each do |comment|
      parent = find_parent_comment(comment.children, parent_id)
    end
    return parent
  end
  
  def set_source
    @source = DataCatalog::Source.first(:slug => params[:slug])
  end
  
end