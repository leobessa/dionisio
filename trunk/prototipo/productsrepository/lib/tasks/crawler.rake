
namespace :crawl do

  desc "Import offers from www.submarino.com.br"
  task :offers => :environment do
    SubmarinoCrawler.new.import_offers
  end

  desc "Import the offer from the passed url "
  task :offer => :environment do
    if ENV['OFFER_PATH']
      path = "http://www.submarino.com.br#{ENV['OFFER_PATH']}"
      puts "Trying to import #{path}"
      SubmarinoCrawler.new.import_offer path
    end
  end

end