class ContactController < ApplicationController
  
  def index
    @contact_submission = ContactSubmission.new
  end
  
  def submit
    @contact_submission = ContactSubmission.new(params[:contact_submission])
    if @contact_submission.save
      flash[:notice] = "Your message has been received."
    else
      render :action => 'index' and return
    end
    redirect_to contact_path
  end
  
end
