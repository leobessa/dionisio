require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserRecommendation do

  it "should create a new instance given valid attributes" do
    Factory.build(:user_recommendation).should be_valid
  end 
  
  [:sender_id,:target_id,:product_id].each do |attribute|
    it "should validate presence of #{attribute}" do  
        @valid_user_recommendation = Factory.build(:user_recommendation) 
        @valid_user_recommendation.send("#{attribute}=",nil)
        @valid_user_recommendation.should_not be_valid
        @valid_user_recommendation.should have(1).error_on(attribute)
      end
  end     
  
  it "should be unique given a product a sender and a target" do 
     a = Factory.create :user_recommendation 
    UserRecommendation.new(a.attributes).should_not be_valid
  end 
  
  it "should not be valid when target has already rated that product" do
    target = Factory :user, :stage_number => 3
    rated_product = Factory :product
    Factory :rating, :user => target, :product => rated_product
    r = Factory.build :user_recommendation, :target => target, :product => rated_product
    r.should_not be_valid
  end
    
  context "sender is on stage 3" do
    it "should not be valid when user has already sent 5 recommendations to the same target" do
      sender = Factory :user, :stage_number => 3
      target = Factory :user, :stage_number => 3, :group => sender.group
      5.times do
        r = Factory.build :user_recommendation, :sender => sender, :target => target
        r.should be_valid
        r.save
      end
      r = Factory.build :user_recommendation, :sender => sender, :target => target
      r.should_not be_valid
    end  
    
    it "should be sent among friends" do 
      sender = Factory :user, :stage_number => 3
      target = Factory :user, :stage_number => 3
      r = Factory.build(:user_recommendation, :sender => sender, :target => target)
      r.should_not be_valid
    end                            
  end
    
  
end
