class AdminController < ApplicationController
  before_filter :require_user, :require_curator
  
  def show

  end
  
  private
  
  def require_curator
    unless current_user.admin_or_curator?
      store_location
      flash[:error] = "You must be an administrator or curator to access that section."
      redirect_to dashboard_path
      return false
    end
  end
  
  def require_admin
    unless current_user.admin?
      store_location
      flash[:error] = "You must be an administrator to access that section."
      redirect_to dashboard_path
      return false
    end
  end
  
end