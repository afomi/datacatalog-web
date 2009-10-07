class User < ActiveRecord::Base

  validates_presence_of :email, :display_name
  
  attr_accessor :api_user, :curator

  before_save :set_update_params
  after_save :update_api_user

  acts_as_authentic do |config|
    config.openid_required_fields = [:nickname, :email]  
  end

  def after_find
    self.api_user = self.api_key ? DataCatalog::User.get_by_api_key(self.api_key) : nil
    rescue ActiveRecord::MissingAttributeError
      nil
  end

  def set_update_params
    @updated_params = {}
    
    @updated_params[:name] = self.display_name if self.display_name_changed?
    @updated_params[:email] = self.email if self.email_changed?
    @updated_params[:curator] = self.curator if self.curator
    
    @updated_params
  end

  def update_api_user
    self.api_user = DataCatalog::User.update(self.api_user.id, @updated_params) unless self.api_key.nil? || @updated_params.empty?
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
    self.api_user = DataCatalog::User.create(:name => self.display_name, :email => self.email)
    self.api_key = self.api_user.primary_api_key
  end
  
  # Use admin?, curator?, and admin_or_curator? for authorization.
  # Never use curator (sans question mark), as it is an in-memory accessor.
  def admin?
    self.api_user.admin
  end

  # Use admin?, curator?, and admin_or_curator? for authorization.
  # Never use curator (sans question mark), as it is an in-memory accessor.
  def curator?
    self.api_user.curator
  end
  
  # Use admin?, curator?, and admin_or_curator? for authorization.
  # Never use curator (sans question mark), as it is an in-memory accessor.
  def admin_or_curator?
    self.admin? || self.curator?
  end

  private

  def map_openid_registration(registration)
    self.email = registration["email"] if email.blank?
    self.display_name = registration["nickname"] if display_name.blank?
  end

end