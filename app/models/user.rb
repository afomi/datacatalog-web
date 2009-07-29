class User < ActiveRecord::Base
  
  validates_presence_of :email
  
  acts_as_authentic do |config|

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
  
  
end