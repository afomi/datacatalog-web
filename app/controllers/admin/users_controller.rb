class Admin::UsersController < AdminController

  before_filter :require_admin
  
  EMAIL_REGEX = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/
  
  def index
    @search_term = params[:search]
    @users = if @search_term
      if @search_term =~ EMAIL_REGEX
        User.find_all_by_email(@search_term)
      else
        User.find(:all, :conditions => 
          ["display_name LIKE ?", "%#{@search_term}%"])
      end
    else
      User.alphabetical
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.attributes = params[:user]
    @user.save do |result|
      if result
        flash[:notice] = "Profile updated!"
      else
        flash[:error] = "Error updating!"
      end
    end
    redirect_to :back
  end
  
end
