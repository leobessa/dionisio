Given /^the following reviews?$/ do |table|  
  Review.transaction do
    table.hashes.each do |hash|
      Review.create(:user => User.find_or_create_by_username(hash[:username]),
      :product => Product.find_or_create_by_name(hash[:product]),
      :rating => hash[:rating])
    end           
  end 
end

Then /^the user "([^\"]*)" probably likes "([^\"]*)"$/ do |name, item|
  user = User.find_by_username(name)
  r = user.recommended_products
  r.should include( Product.find_by_name(item))
end


Then /^the user "([^\"]*)" is similar to "([^\"]*)"$/ do |a, b|
  user_a = User.find_by_username(a)
  user_b = User.find_by_username(b)
  users = user_a.similar_users
  users.should include( user_b)
end
