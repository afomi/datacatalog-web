class User < ActiveRecord::Base
  acts_as_authentic do |config|

  end
  
  validates_presence_of :email, :password, :password_confirmation
end