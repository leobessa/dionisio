Factory.sequence :email do |n|
    "person#{n}@example.com"
end

Factory.define :invitation do |f|
  f.recipient_email { Factory.next(:email) }
end

Factory.define :user do |f|                   
  f.sequence(:name){ |n| "João 123#{n} da Silva"}
  f.invitation { Factory.create(:invitation) }
  f.email { Factory.next(:email) }
  f.password "secret"
  f.password_confirmation {|u| u.password}
  f.sex "M"
  f.age_group '18 a 25'
end 

Factory.define :admin do |f|                   
  f.email { Factory.next(:email) }
  f.password "secret"
end
  