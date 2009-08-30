# lib/tasks/populate.rake
namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [Product, User, Offer, Business, Review].each(&:delete_all)
    
    Business.populate 5 do |bussines|
      bussines.name = Faker::Company.name.titleize
      bussines.url = Faker::Internet.domain_name
    end
    
    Category.populate 10 do |category|
      category.name = Populator.words(1..3).titleize
      Product.populate 10..100 do |product|
        product.category_id = category.id
        product.name = Populator.words(1..5).titleize
        product.description = Populator.sentences(2..10)
        product.created_at = 2.years.ago..Time.now
        Offer.populate 1..3 do |offer|
          offer.product_id = product.id
          offer.list_price = 1..100
          offer.path = "/produto/#{Offer.count}"
          offer.business_id = Business.all.rand.id
        end
      end
    end
    
    User.populate 50 do |user|
      user.username = Faker::Internet.user_name
      user.email    = Faker::Internet.email
    end
    
    Review.populate 500 do |review|
      review.product_id = Product.all.rand.id
      review.user_id = User.all.rand.id
      review.rating = 0..5
      review.description = Populator.sentences(2..10)
      review.summary = Populator.sentences(1)
    end
    
  end
end