class DataSubmission < Submission
  
  validates_presence_of :title, :url
  
end