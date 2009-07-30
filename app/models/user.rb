class User < ActiveRecord::Base
  
  validates_presence_of :email, :display_name
  
  acts_as_authentic do |config|
    config.openid_required_fields = [:nickname, :email]  
  end
  
  def confirmed?
    self.confirmed_at || false
  end
  
  def confirm!
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
  
  private
  
  def map_openid_registration(registration)
    self.email = registration["email"] if email.blank?
    self.display_name = registration["nickname"] if display_name.blank?
  end
  
end