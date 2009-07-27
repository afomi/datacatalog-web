Given /^I am a site visitor$/ do
  visit signout_path
end

Given /^I am a site visitor who already has signed up with "([^\"]*)"$/ do |email|
  User.create!(:email => email, :password => 'test', :password_confirmation => 'test')
end

Then /^my account should be created$/ do
  @user = User.find_by_email('john@test.com')
  @user.should be_an_instance_of(User)
end

Then /^my account should not be created$/ do
  @user = User.find_by_email('jack@test.com')
  @user.should be(nil)
end