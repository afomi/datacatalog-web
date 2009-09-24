class Submission < ActiveRecord::Base
  
  validate :identify_submitter
  
  private 
  
  def identify_submitter
    if user_id.nil? and (name.blank? or email.blank?)
      errors.add_to_base("Your name and email are required")
    end
  end
  
end