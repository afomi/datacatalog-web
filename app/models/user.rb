class User < ActiveRecord::Base

  validates_presence_of :email, :display_name
  
  attr_accessor :api_user

  acts_as_authentic do |config|
    config.openid_required_fields = [:nickname, :email]  
  end
  
  def after_find
    self.api_user = self.api_key ? DataCatalog::User.find_by_api_key(self.api_key) : nil
    rescue ActiveRecord::MissingAttributeError
      nil
  end

  def confirmed?
    self.confirmed_at || false
  end

  def confirm!
    create_api_user
    self.confirmed_at = Time.now
    save!
  end

  def deliver_confirmation_instructions!
    reset_perishable_token!
    Notifier.deliver_confirmation_instructions(self)
  end

  def deliver_welcome_message!
    reset_perishable_token!
    Notifier.deliver_welcome_message(self)
  end

  def create_api_user
    api_user = DataCatalog::User.create(:name => self.display_name, :email => self.email)
    self.api_key = api_user.primary_api_key
  end

  def admin?
    api_user.admin
  end
  
  def curator?
    api_user.curator
  end
  
  def admin_or_curator?
    api_user.admin || api_user.curator
  end

  private

  def map_openid_registration(registration)
    self.email = registration["email"] if email.blank?
    self.display_name = registration["nickname"] if display_name.blank?
  end

end