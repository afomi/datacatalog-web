class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save do |result|
      if result
        if @user_session.user.confirmed?
          flash[:notice] = "You have been signed in."
          redirect_to root_url and return
        else
          flash[:error] = "Your account is not confirmed. Check your email for confirmation instructions."
          render :action => "new" and return
        end
      else
        render :action => "new" and return
      end
    end
    flash[:error] = "Your account is not confirmed. Check your email for confirmation instructions."
    render :action => "new"
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "You have been signed out."
    redirect_to root_url
  end

end
