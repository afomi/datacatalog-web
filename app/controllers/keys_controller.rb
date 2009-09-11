class KeysController < ApplicationController
  before_filter :require_user
  
  def new
    @key = DataCatalog::ApiKey.new
  end
  
  def show
    
  end
  
  def create
    DataCatalog.with_key(current_user.api_key) do
      current_user.api_user.generate_api_key!({:purpose  =>  params['key']['purpose'],
                                               :key_type =>  params['key']['key_type']})
    end
    flash[:notice] = "New API key generated!"
    redirect_to profile_path
  end
  
  def update
    DataCatalog.with_key(current_user.api_key) do
      current_user.api_user.update_api_key!(params[:id], {:purpose  =>  params['key']['purpose'],
                                                          :key_type =>  params['key']['key_type']})
    end
    flash[:notice] = "The API key has been updated."
    redirect_to profile_path
  end
  
  def edit
    @key = current_user.api_user.api_keys.select do |key|
      key.id == params[:id]
    end.first
  end
  
  def destroy
    DataCatalog.with_key(current_user.api_key) do
      current_user.api_user.delete_api_key!(params[:id])
    end
    flash[:notice] = "The API key has been deleted."
    redirect_to profile_path
  end
  
end