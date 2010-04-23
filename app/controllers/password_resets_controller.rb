class PasswordResetsController < ApplicationController
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  def new
  end

  def create
    @user = User.find_by_email(params[:email_address])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = "Instructions to reset your password have been emailed to you."
      redirect_to signin_url
    else
      flash[:error] = "The email address #{params[:email_address]} has not been found. Try <a href='" + signup_path + "'>signing up</a>."
      redirect_to forgot_url
    end
  end

  def edit
  end

  def update
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save
      flash[:notice] = "Your password was successfully updated!"
      redirect_to @user
    else
      flash[:error] = "Your passwords didn't match!"
      redirect_to reset_url
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:token])
    unless @user
      flash[:error] = "We could not locate your account."
      redirect_to signin_url
    end
  end
end