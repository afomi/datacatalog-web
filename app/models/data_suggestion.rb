class DataSuggestion < Submission
  
  validate :ensure_detail
  
  attr_human_name 'title' => 'Data Source Title'
  attr_human_name 'url' => 'Data Source URL'
  
  private
  
  def ensure_detail
    if title.blank? and url.blank? and comments.blank?
      errors.add_to_base("Please be more detailed about your suggestion.")
    end
  end

end