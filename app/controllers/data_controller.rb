class DataController < ApplicationController
  
  before_filter :set_source
  
  def show
    
  end
  
  def comment
    DataCatalog.with_key(current_user.api_key) do
      DataCatalog::Comment.create(:source_id => @source.id, :text => params[:comment_text])
    end
    flash[:notice] = "Comment saved!"
    redirect_to :back
  end
  
  private
  
  def set_source
    @source = DataCatalog::Source.first(:slug => params[:slug])
  end
  
end