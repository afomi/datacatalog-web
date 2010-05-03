class Notifier < ActionMailer::Base
  
  def confirmation_instructions(user)
    subject       "Please confirm your account"
    from          "National Data Catalog <natdatcat@sunlightfoundation.com>"
    recipients    user.email
    sent_on       Time.now
    body          :confirmation_url => confirm_url(user.perishable_token)
  end

  def welcome_message(user)
    subject       user.openid_identifier ? "Thanks for signing up!" : "Thanks for confirming!"
    from          "National Data Catalog <natdatcat@sunlightfoundation.com>"
    recipients    user.email
    sent_on       Time.now
    body          :profile_url => profile_url, :api_key => user.api_key
  end

  def password_reset_instructions(user)
    subject      "Password Reset Instructions"
    from         "National Data Catalog <natdatcat@sunlightfoundation.com>"
    recipients   user.email
    sent_on      Time.now
    body         :reset_url => reset_url(user.perishable_token)
  end
  
  def contact_submission(contact_submission)
    subject      "Contact Us: #{contact_submission.title}"
    from         "National Data Catalog <natdatcat@sunlightfoundation.com>"
    recipients   "National Data Catalog <natdatcat@sunlightfoundation.com>"
    sent_on      Time.now
    body <<-BLOCK
      From:
      #{contact_submission.name} <#{contact_submission.email}>
      
      Comments:
      #{contact_submission.comments}
      
      Admin URL:
      #{admin_contact_submission_path(contact_submission)}
    BLOCK
  end
  
  def data_suggestion(data_suggestion)
    subject      "Data Suggestion: #{data_suggestion.title}"
    from         "National Data Catalog <natdatcat@sunlightfoundation.com>"
    recipients   "National Data Catalog <natdatcat@sunlightfoundation.com>"
    sent_on      Time.now
    body <<-BLOCK
      From:
      #{data_suggestion.name} <#{data_suggestion.email}>
      
      Data Source Title:
      #{data_suggestion.title}
      
      Data Source URL:
      #{data_suggestion.url}
      
      Comments:
      #{data_suggestion.comments}
      
      Admin URL:
      #{admin_contact_submission_path(data_suggestion)}
    BLOCK
  end

end
