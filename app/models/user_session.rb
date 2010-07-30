class UserSession < Authlogic::Session::Base

  validate :check_confirmed_user

  private

  def check_confirmed_user
    #errors.add_to_base("Your account is not confirmed!") unless self.attempted_record.confirmed?
  end

end
