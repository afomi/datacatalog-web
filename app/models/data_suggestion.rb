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

class DataSuggestion < Submission
  include SubmissionTools

  validate :ensure_detail
  acts_as_taggable_on :folders
  after_create :add_to_inbox

  attr_human_name 'title' => 'Data Source Title'
  attr_human_name 'url' => 'Data Source URL'

  private

  def ensure_detail
    if title.blank? and url.blank? and comments.blank?
      errors.add_to_base("Please be more detailed about your suggestion.")
    end
  end

end
