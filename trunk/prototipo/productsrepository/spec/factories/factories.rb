Factory.define :user do |f|
  f.sequence(:username) { |n| "foo#{n}" }
  f.password "foobar"
  f.password_confirmation { |u| u.password }
  f.sequence(:email) { |n| "foo#{n}@example.com" }
end

Factory.define :review do |f|
  f.user {|a| a.association(:user) }
  f.product {|a| a.association(:product) }
  f.rating 3
end

Factory.define :product do |f|
  f.name { |n| "Mr. Foo#{n}" }
end    

Factory.define :friendship do |f|
  f.sequence(:user_id) { |n| n }
  f.sequence(:friend_id) { |n| n }
end