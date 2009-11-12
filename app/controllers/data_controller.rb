class DataController < ApplicationController
  
  before_filter :set_source
  
  def show
    
    @comment = DataCatalog::Comment.new
    @comments = []
    @source.comments.each do |comment|
      comment.id = extract_id(comment.href)
      comment.children = []
      comment.user = User.find_by_api_id(extract_id(comment.user.href))
      if comment.parent
        find_parent_comment(@comments, comment.parent.id).children << comment
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
  
  private
  
  def find_parent_comment(comments, parent_id)
    comments.each do |comment|
      if comment.id == parent_id
        return comment
      elsif !comment.children.empty?
        find_parent_comment(comment.children, parent_id)
      else
        next
      end
    end

  end
  
  def set_source
    @source = DataCatalog::Source.first(:slug => params[:slug])
  end
  
end