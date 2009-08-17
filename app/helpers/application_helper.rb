# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def custom_error_messages
    { :header_message => "", :message => "The following problems occurred:" }
  end
end
