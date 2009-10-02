class SuggestController < ApplicationController
  
  def index
    @data_suggestion = DataSuggestion.new
  end
  
  def suggest
    @data_suggestion = DataSuggestion.new(params[:data_suggestion])
    if @data_suggestion.save
      flash[:notice] = "Thanks! Your suggestion has been received. It will be reviewed by our curators."
    else
      render :action => 'index' and return
    end
    redirect_to suggest_path
  end
  
end
