# I want to get a user's primary API key
user = DataCatalog::User.find(user_id)
user.primary_api_key
user.application_api_keys
user.valet_api_keys

# I want to generate a new API key for a user
user.generate_api_key!(:type => "application", :purpose => "To be awesome.") # sets user to the updated object

# I want to update an API key
user.update_api_key!("173f938237a93e9393b365c3", 
                    :type => "application", 
                    :purpose => "To be more awesome.") # sets user to the updated object

# I want to delete an API key of a user
user.delete_api_key!("173f938237a93e9393b365c3") # returns: true / exception

# I want to get all API keys of a single user
user.api_keys # returns: array of keys

# ^^^^^^^^^^^^ DONE ^^^^^^^^^^^^^^^

# vvvvvvvvvv NOT DONE vvvvvvvvvvvvv 

# Given an API key, I want to see what user it corresponds to, if any.
DataCatalog::User.find_by_api_key("7a93e93b365ca93e9393b365c3") # returns: User object
