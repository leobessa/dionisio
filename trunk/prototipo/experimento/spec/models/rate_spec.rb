require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rate do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :rateable_id => 1,
      :rateable_type => "value for rateable_type",
      :stars => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Rate.create!(@valid_attributes)
  end  
  
  it "should be unique for a user and rateable item" do 
    attributes = {:user_id => 100, :rateable_id => 1,:rateable_type => "Product", :stars => 1}
    Rate.create(attributes)
    Rate.new(attributes).should_not be_valid
    Rate.new(attributes.merge!(:rateable_id => 2)).should be_valid
    Rate.new(attributes.merge!(:rateable_type => "OtherType")).should be_valid
    Rate.new(attributes.merge!(:user_id => 444)).should be_valid
  end
  
end
