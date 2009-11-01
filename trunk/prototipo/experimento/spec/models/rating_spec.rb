require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rating do

  it "should create a new instance given valid attributes" do
    valid_rating = Factory.build(:rating)
    valid_rating.should be_valid
  end  
  
  it "should be unique given a user and a product" do
    a = Factory :rating
    x = Rating.new a.attributes
    x.should_not be_valid  
    y = Rating.new a.attributes.merge(:user => (Factory :user))
    y.should be_valid
    z = Rating.new a.attributes.merge(:product => (Factory :product))
    z.should be_valid
  end
end
