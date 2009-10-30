require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserRecommendation do
  before(:each) do
    @valid_attributes = {
      :sender_id => 1,
      :target_id => 2,
      :product_id => 1
    }    
    @valid_user_recommendation = UserRecommendation.create @valid_attributes
  end

  it "should create a new instance given valid attributes" do
    @valid_user_recommendation.should be_valid
  end 
  
  [:sender_id,:target_id,:product_id].each do |attribute|
    it "should validate presence of #{attribute}" do
        @valid_user_recommendation.send("#{attribute}=",nil)
        @valid_user_recommendation.should_not be_valid
        @valid_user_recommendation.should have(1).error_on(attribute)
      end
  end     
  
  it "should be unique given a product a sender and a target" do
    attributes = { :sender_id => 2, :target_id => 3, :product_id => 3 }
    UserRecommendation.create(attributes)
    UserRecommendation.new(attributes).should_not be_valid 
    UserRecommendation.new(attributes.merge(:sender_id => 4)).should be_valid
    UserRecommendation.new(attributes.merge(:target_id => 4)).should be_valid
    UserRecommendation.new(attributes.merge(:product_id => 4)).should be_valid
  end
    
  
end
