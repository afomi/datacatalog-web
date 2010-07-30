class Admin::DataSuggestionsController < AdminController

  before_filter :set_folders

  def index
    @folder_name = if params[:folder].blank?
      "Inbox"
    else
      params[:folder]
    end
    @suggestions = DataSuggestion.reverse_chronological.find_tagged_with(
      @folder_name, :on => :folders)
  end

  def show
    @suggestion = DataSuggestion.find(params[:id])
    @suggestion.read! if @suggestion.status == "Unread"
  end

  def update
    @suggestion = DataSuggestion.find(params[:id])
    @suggestion.attributes = params[:data_suggestion]
    if @suggestion.save
      flash[:notice] = "Suggestion updated"
    else
      flash[:error] = "Error updating suggestion!"
    end
    redirect_to :back
  end

  def set_folders
    @folders = DataSuggestion.folder_counts
  end

end
