class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create, :confirm]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save_without_session_maintenance
      @user.deliver_confirmation_instructions!
      flash[:notice] = "Your account has been created. Please check your email inbox to confirm your email address."
      redirect_to signin_url
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end
 
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile updated!"
      redirect_to profile_url
    else
      render :action => :edit
    end
  end
  
  def confirm
    @user = User.find_using_perishable_token(params[:token], 1.month)
    if @user.nil? || @user.confirmed?
      flash[:notice] = "No confirmation needed! Try signing in."
      redirect_to signin_url
    elsif @user.confirm!
      #@user.assign_api_key!
      @user.deliver_welcome_message!
      UserSession.create(@user)
      flash[:notice] = "Thanks! Your email address has been confirmed and you're now signed in."
      redirect_to profile_url
    else
      flash[:error] = "Sorry, could not confirm the email address."
      redirect_to signup_url
    end
  end
end