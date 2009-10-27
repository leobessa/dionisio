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
  f.stage_number 1
end 

Factory.define :admin do |f|                   
  f.email { Factory.next(:email) }
  f.password "secret"
end

Factory.define :leo_user, :class => :user do |f|
  f.name "Leonardo Bessa"
  f.invitation { Factory.create(:invitation) }
  f.email "leobessa@gmail.com"
  f.password "secret"
  f.password_confirmation {|u| u.password}
  f.sex "M"
  f.age_group '18 a 25'
  f.stage_number 1
end

Factory.define :category do |f|
  f.sequence :name do |n| 
    "#{Populator.words(1..3).titleize} #{n}"  
  end
end   

Factory.define :product do |f|
  f.name { Populator.words(1..5).titleize }
  f.brand { Populator.words(1..2).titleize }
  f.description { Populator.sentences(2..8) }
  f.price { [4.99, 19.95, 100].rand }
  f.category do |p|
    if Category.count > 3
      Category.all[rand(Category.count)]
    else
      p.association :category
    end
  end
end
