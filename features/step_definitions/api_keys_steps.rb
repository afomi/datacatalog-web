Given /^I am signed in$/ do
  u = User.create!(:display_name => 'John D.', :email => 'some@email.com', :password => 'test', :password_confirmation => 'test')
  u.confirm!
  @user = User.find_by_api_key(u.api_key)

  visit signin_path
  fill_in("Email", :with => "some@email.com")
  fill_in("Password", :with => "test")
  click_button("Sign In")
end

Given /^I have an existing application key with "([^\"]*)" as its purpose$/ do |purpose|
  @user.api_user.generate_api_key!(:key_type => "application", :purpose => purpose)
end

When /^I choose to "([^\"]*)" that key$/ do |action|
  within "table#keys tr:nth-child(3)" do
    click_link action
  end
end
