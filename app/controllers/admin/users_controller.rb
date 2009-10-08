class Admin::UsersController < AdminController
  
  def index
    if @search_term = params[:search]
      if @search_term =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/
        @users = User.find_all_by_email(@search_term)
      else
        @users = User.find(:all, :conditions => ["display_name LIKE ?", "%#{@search_term}%"])
      end  
    else
      @users = User.alphabetical
    end
  end
  
end