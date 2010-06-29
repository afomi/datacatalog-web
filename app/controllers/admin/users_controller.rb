class Admin::UsersController < AdminController

  before_filter :require_admin
  
  def index
    if @search_term = params[:search]
      if @search_term =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/
        @users = User.find_all_by_email(@search_term)
      else
        @users = User.find(:all, :conditions =>
          ["display_name LIKE ?", "%#{@search_term}%"])
      end  
    else
      @users = User.alphabetical
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
