class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  before_filter :activate_authlogic 

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new params[:user_session] 
    @user_session.save do |result|      
      if result
        flash[:notice] = "You have been signed in."
        redirect_to root_path and return
      else
        render :action => "new" and return
      end      
    end
  end
  
  def update
    create
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "You have been signed out."
    redirect_to root_url
  end

end
