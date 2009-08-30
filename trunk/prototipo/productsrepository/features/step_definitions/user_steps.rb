Given /^the following (.+) records?$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end 

Given /^I am not logged in$/ do
  visit logout_url
end

Given /^I am logged in as "(.*)" with password "([^\"]*)"$/ do |username, password|
  @user = User.find_by_username(username)
  if @user.nil?
    @user = Factory :user, :username => username , :password => password 
  end
  visit login_path
  fill_in "Username", :with => username
  fill_in "Password", :with => password
  click_button "Submit"
end

When /^I visit profile for "([^\"]*)"$/ do |username|
  user = User.find_by_username!(username)
  visit user_url(user)
end                        

Then /^I should be logged in as "(.*)"$/ do |username|
  session = UserSession.find
  session.should_not be_nil
  session.user.should_not be_nil
  session.user.username.should == username
end

Then /^I should not be logged in$/ do
  session = UserSession.find
  session.should be_nil
end