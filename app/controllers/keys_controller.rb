class KeysController < ApplicationController
  before_filter :require_user
  
  def new
    
  end
  
  def show
    
  end
  
  def create
    api_user = DataCatalog::User.find_by_api_key(current_user.api_key)
    DataCatalog.with_key(current_user.api_key) do
      api_user.generate_api_key!({:purpose  =>  params['key']['purpose'],
                                  :key_type =>  params['key']['key_type']})
    end
    flash[:notice] = "New API key generated!"
    redirect_to profile_path
  end
  
  def edit
    
  end
  
  def destroy
    
  end
  
end