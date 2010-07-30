Given /^I am a site visitor$/ do
  visit signout_path
end

Given /^I am a site visitor who already has signed up with "([^\"]*)"$/ do |email|
  u = User.create!(:display_name => 'John D.', :email => email, :password => 'test', :password_confirmation => 'test')
  u.confirm!
  @user = User.find_by_api_key(u.api_key)
end

Given /^I have signed up but not yet confirmed$/ do
  User.create!(:display_name => 'John D.', :email => 'some@email.com', :password => 'test', :password_confirmation => 'test')
end

Given /^I have signed up via OpenID but not yet confirmed$/ do
  User.create!(:display_name => 'John D.', :email => 'some1@email.com', :openid_identifier => "http://someid.com/")
end

When /^I click on the confirmation link$/ do
  unconfirmed_user = User.find_by_email('some@email.com')
  visit confirm_path(:token => unconfirmed_user.perishable_token)
end

Then /^my account should be created$/ do
  @user = User.find_by_email('john@test.com')
  @user.should be_an_instance_of(User)
end

Then /^my OpenID-enabled account should be created$/ do
  @user = User.find_by_openid_identifier('http://johndoe.myopenid.com/')
  @user.should be_an_instance_of(User)
end

Then /^my account should not be created$/ do
  @user = User.find_by_email('jack@test.com')
  @user.should be(nil)
end
