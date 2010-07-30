class Admin::ContactSubmissionsController < AdminController

  before_filter :set_folders

  def index
    @folder_name = if params[:folder].blank?
      "Inbox"
    else
      params[:folder]
    end
    @submissions = ContactSubmission.reverse_chronological.find_tagged_with(
      @folder_name, :on => :folders)
  end

  def show
    @submission = ContactSubmission.find(params[:id])
    @submission.read! if @submission.status == "Unread"
  end

  def update
    @submission = ContactSubmission.find(params[:id])
    @submission.attributes = params[:data_suggestion]
    if @submission.save
      flash[:notice] = "Submission updated"
    else
      flash[:error] = "Error updating submission!"
    end
    redirect_to :back
  end

  def set_folders
    @folders = ContactSubmission.folder_counts
  end

end
