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

  belongs_to :user
  validate :identify_submitter
  before_create :unread!

  named_scope :unread, :conditions => {:status => 'Unread'}
  named_scope :read, :conditions => {:status => 'Read'}
  named_scope :archived, :conditions => {:status => 'Archived'}
  named_scope :reverse_chronological, :order => 'created_at DESC'
  
  def unread!
    self.status = 'Unread'
  end
  
  def read!
    self.status = 'Read'
  end
  
  def archived!
    self.status = 'Archived'
  end
  
  private 
  
  def identify_submitter
    if user_id.nil? and (name.blank? or email.blank?)
      errors.add_to_base("Your name and email are required")
    end
  end
  
end
