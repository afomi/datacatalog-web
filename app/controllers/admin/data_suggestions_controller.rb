class Admin::DataSuggestionsController < AdminController
  
  before_filter :set_folders
  
  def index
    if params[:folder].blank?
      @folder_name = "Inbox"
    else  
      @folder_name = params[:folder]
    end
    
    @suggestions = DataSuggestion.find_tagged_with(@folder_name, :on => :folders)
  end
  
  def set_folders
    @folders = DataSuggestion.folder_counts
  end
  
end