require 'submarino_offer_parser.rb'

namespace :crawl do

  desc "Import offers from www.submarino.com.br"
  task :offers => :environment do
    SubmarinoCrawler.new.import_offers
  end 
  
  desc "Bootstrap offers from www.submarino.com.br"
  task :bootstrap => :environment do
    c = SubmarinoCrawler.new       
      %w(  
         1/21573870 1/21472846 1/21567195 1/56122 1/21497184
         10/21542460 10/21464403 10/21558070 10/21560022 10/21607417
         11/21536168  11/21412550 11/21543149 11/21468668 11/21496121
         12/21617329 12/21498232 12/21360636
       ).each do |resource|                            
        c.import_offer "http://www.submarino.com.br/produto/#{resource}" 
      end
  end

  desc "Import the offer from the passed url "
  task :offer => :environment do
    if ENV['OFFER_PATH']
      path = "http://www.submarino.com.br#{ENV['OFFER_PATH']}"
      puts "Trying to import #{path}"
      SubmarinoCrawler.new.import_offer path
    end
  end
  
  desc "Import a list of local offers from STDIN"
  task :local => :environment do
    if ENV['OFFER_PATH'] then
      p = SubmarinoOfferParser.new
      noffers = 0
      ActiveRecord::Base.transaction do
        STDIN.each do |path|
          path = path.strip
          base = ENV['OFFER_PATH']
          full_path = "#{base}/#{path}"
          puts "Processing offer file: #{full_path}"
          noffers += 1
          puts noffers
          begin
            html = File.open(full_path, "r").read
            uri = "http://www.submarino.com.br/#{path}"
            ranking_path = full_path + ".ranking"
            if File.exists? ranking_path then
              ranking = File.open(ranking_path, "r").read
              popularity = -Integer.parse(ranking)
              p.parser_offer html, uri, popularity
            else
              p.parser_offer html, uri
            end
          rescue Exception => e  
            puts "Problems parsing #{path}"
            puts e.message  
            puts e.backtrace.inspect  
          end
        end
      end
    else
      puts "Set env OFFER_PATH to the base directory of files"
    end
  end

end