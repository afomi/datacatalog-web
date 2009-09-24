class DataSubmission < Submission
  
  validates_presence_of :title, :url
  attr_human_name 'title' => 'Data Source Title'
  attr_human_name 'url' => 'Data Source URL'

  
end