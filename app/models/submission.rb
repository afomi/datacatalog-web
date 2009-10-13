# == Schema Information
#
# Table name: submissions
#
#  id         :integer(4)      not null, primary key
#  type       :string(255)
#  name       :string(255)
#  email      :string(255)
#  user_id    :integer(4)
#  title      :string(255)
#  url        :string(255)
#  comments   :text
#  created_at :datetime
#  updated_at :datetime
#  status     :string(255)
#

class Submission < ActiveRecord::Base
  
  validate :identify_submitter
  
  private 
  
  def identify_submitter
    if user_id.nil? and (name.blank? or email.blank?)
      errors.add_to_base("Your name and email are required")
    end
  end
  
end
