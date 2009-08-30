require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require 'open-uri'
require 'fakeweb'

Given /^the uri '(.*)' is at the '(.*)' file$/ do |link,file_name|
    FakeWeb.allow_net_connect = false 
    FakeWeb.register_uri(:get, link, :response => File.join(RAILS_ROOT, 'features', 'files', file_name))
end

When /^I fetch the offer in '(.*)'$/ do |link|
  @offer = SubmarinoOfferParser.new.fetch_offer(URI.parse(link))
end

Then /^the category name of the offer should be '(.*)'$/ do |value|
  @offer.category.name.should == value
end

Then /^the offer (.*) should be '(.*)'$/ do |key,value|
  @offer.send(key).should == value
end

Then /^the offer (.*) should be nil$/ do |key|
  assert(@offer.send(key).nil?, "the #{key} should be nil.")  
end

Then /^the offer (.*) should be '(.*)' as integer$/ do |key,value|
  @offer.send(key).should == value.to_i
end