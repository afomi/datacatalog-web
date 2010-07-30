class ContactController < ApplicationController

  def index
    @contact_submission = ContactSubmission.new
  end

  def submit
    @contact_submission = ContactSubmission.new(params[:contact_submission])
    if @contact_submission.save
      Notifier.deliver_contact_submission(@contact_submission)
      flash[:notice] = "Your message has been received."
      redirect_to contact_path
    else
      render :action => 'index'
    end
  end

end
