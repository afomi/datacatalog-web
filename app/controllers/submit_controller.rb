class SubmitController < ApplicationController
  
  def index
    @data_submission = DataSubmission.new
  end
  
  def submit
    @data_submission = DataSubmission.new(params[:data_submission])
    if @data_submission.save
      flash[:notice] = "Thanks! Your submission has been received. It will be reviewed by our curators."
    else
      render :action => 'index' and return
    end
    redirect_to submit_path
  end
  
end
