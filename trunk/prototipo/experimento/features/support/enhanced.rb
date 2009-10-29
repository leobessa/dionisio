Webrat.configure do |config|
  config.mode                       = :selenium
  # Selenium defaults to using the selenium environment. Use the following to override this.
  config.application_environment    = :cucumber
  #config.action_controller.session = { :session_http_only => false }
  #config.application_address       = 'localhost' 
  #config.application_port           = 3000
  #config.application_framework      = :rails
end
   
Cucumber::Rails::World.use_transactional_fixtures = false

# this is necessary to have webrat "wait_for" the response body to be available
# when writing steps that match against the response body returned by selenium
#World(Webrat::Selenium::Matchers)

Before do 
  begin
    selenium.set_speed 100
  rescue NoMethodError
  end
  # truncate your tables here, since you can't use transactional fixtures* 
  [Admin,Category,Invitation,Product,Rate,Stage,User].each(&:destroy_all)
  load File.join( RAILS_ROOT, 'db', 'seeds.rb')
end     

After do
  visit destroy_user_session_path
end
