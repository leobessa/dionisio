# truncate your tables here if you are using the same database as selenium, since selenium doesn't use transactional fixtures
Cucumber::Rails::World.use_transactional_fixtures = true

Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end                                                        

Before do 
  Stage.create! :number => 1, :enabled => true
  Stage.create! :number => 2, :enabled => false
  Factory.create :user, :email => "user@email.com", :password => "secret"        
end