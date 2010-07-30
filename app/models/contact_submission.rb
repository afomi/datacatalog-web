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

class ContactSubmission < Submission
  include SubmissionTools

  validates_presence_of :comments
  acts_as_taggable_on :folders
  after_create :add_to_inbox

end
