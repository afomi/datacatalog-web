Given /^I have signed up and confirmed$/ do 
  u = User.create!(:display_name => 'John D.', :email => 'some@email.com', :password => 'test', :password_confirmation => 'test')
  u.confirm!
end