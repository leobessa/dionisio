require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rating do

  it "should create a new instance given valid attributes" do
    valid_rating = Factory.build(:rating)
    valid_rating.should be_valid
  end  
  
  it "should be unique for a user and rateable item" do 
    attributes = {:user_id => 100, :product_id => 1, :stars => 1}
    Rating.create(attributes)
    Rating.new(attributes).should_not be_valid
    Rating.new(attributes.merge!(:product_id => 2)).should be_valid
    Rating.new(attributes.merge!(:user_id => 444)).should be_valid
  end
end
