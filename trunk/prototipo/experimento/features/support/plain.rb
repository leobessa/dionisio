# truncate your tables here if you are using the same database as selenium, since selenium doesn't use transactional fixtures
Cucumber::Rails::World.use_transactional_fixtures = true

Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end      

require 'rubygems'
require 'rake'

                                                  

Before do
  load File.join( RAILS_ROOT, 'db', 'seeds.rb')
end