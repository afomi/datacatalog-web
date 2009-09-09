Given /^I am signed in$/ do 
  u = User.create!(:display_name => 'John D.', :email => 'some@email.com', :password => 'test', :password_confirmation => 'test')
  u.confirm!
  visit signin_path
  fill_in("Email", :with => "some@email.com")
  fill_in("Password", :with => "test")
  click_button("Sign In")
end

Then /^I should have a new "([^\"]*)" key with "([^\"]*)" as its purpose$/ do |key_type, purpose|
  response.should contain(purpose) 
end