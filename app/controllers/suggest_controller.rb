class SuggestController < ApplicationController
  
  def index
    @data_suggestion = DataSuggestion.new
  end
  
  def suggest
    @data_suggestion = DataSuggestion.new(params[:data_suggestion])
    if @data_suggestion.save
      Notifier.deliver_data_suggestion(@data_suggestion)
      flash[:notice] = "Thanks! Your suggestion has been received. It will be reviewed by our curators."
      redirect_to suggest_path
    else
      render :action => 'index'
    end
  end
  
end
