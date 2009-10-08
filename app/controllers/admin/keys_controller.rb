class Admin::KeysController < AdminController
  before_filter :require_user, :find_user
  
  def destroy
    @user.api_user.delete_api_key!(params[:id])
    flash[:notice] = "The API key has been deleted."
    redirect_to :back
  end
  
  def find_user
    @user = User.find(params[:user_id])
  end
  
end