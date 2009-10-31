require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Recommender do

  context "finding users similarity" do


    it "should be 0 when intersection is empty" do
      @foo = Factory.create :user
      @boo = Factory.create :user
      Recommender.pearson_correlation(@foo,@boo).should == 0.0
    end


    it "should be 0 when intersection has 1 item" do
      @foo = Factory.create :user
      @boo = Factory.create :user 
      @product = Factory :product
      Factory :rating, :user => @foo, :product => @product, :stars => 3
      Factory :rating, :user => @boo, :product => @product, :stars => 4
      Recommender.pearson_correlation(@foo,@boo).should be_close(0.0,0.001)
    end

    it "should be the pearson correlaction when intersection has 2 items" do
      x = Factory.create :user
      y = Factory.create :user 

      [{x => 1, y => 2},{x => 2, y => 5}].each do |point|               
        product = Factory :product
        point.each_pair do |user,stars|
          Factory :rating, :user => user, :product => product  , :stars => stars
        end
      end

      Recommender.pearson_correlation(x,y).should == 1.0
    end

    it "should be the pearson correlaction when intersection has more than 2 items" do
      x = Factory.create :user
      y = Factory.create :user 

      [{x => 2, y => 5},{x => 3, y => 1},{x => 4, y => 2}].each do |point|               
        product = Factory :product
        point.each_pair do |user,stars|
          Factory :rating, :user => user, :product => product  , :stars => stars
        end
      end

      Recommender.pearson_correlation(x,y).should be_close(-0.721,0.001)
    end

    it "should be -1 when intersection user ratings are totally different" do
      x = Factory.create :user
      y = Factory.create :user 

      [{x => 1, y => 5},{x => 5, y => 1},{x => 4, y => 2}].each do |point|               
        product = Factory :product
        point.each_pair do |user,stars|
          Factory :rating, :user => user, :product => product  , :stars => stars
        end
      end

      Recommender.pearson_correlation(x,y).should be_close(-1.0,0.001)
    end

    it "should be 1 when intersection user ratings are totally equal" do
      x = Factory.create :user
      y = Factory.create :user 

      [{x => 5, y => 5},{x => 1, y => 1},{x => 2, y => 2}].each do |point|               
        product = Factory :product
        point.each_pair do |user,stars|
          Factory :rating, :user => user, :product => product  , :stars => stars
        end
      end

      Recommender.pearson_correlation(x,y).should == 1.0
    end
    
    it "should find users with similar profiles" do
      user = Factory :user
      similar_user = Factory :user
      not_similar_user = Factory :user
      Recommender.should_receive(:pearson_correlation).with(user,similar_user).and_return(1.0)
      Recommender.should_receive(:pearson_correlation).with(user,not_similar_user).and_return(-1.0)
      similar_users = Recommender::ProfileBased.similar_users(user)
      similar_users.should include(similar_user)
      similar_users.should_not include(not_similar_user)
      similar_users.should_not include(user)
    end

  end
  

  context "making profile based recommendations" do 

    it "should be empty when user has no ratings" do
      x = Factory.create :user
      Recommender::ProfileBased.recommendations_for(x).should be_empty   
    end 
    
    it "should find unrated products which are nice to similiar users" do                                                            
      user_x = Factory :user
      similiar_friend = Factory :user
      product = Factory :product    
      Factory :rating, :user => user_x,         :stars => 4
      Factory :rating, :user => similiar_friend, :stars => 4, :product => product
      Recommender::ProfileBased.should_receive(:similar_users).with(user_x).and_yield(similiar_friend,0.5)
      recommendations = Recommender::ProfileBased.recommendations_for(user_x)
      recommendations.should include(product) 
      recommendations.length.should == 1
      recommendations.first.recommendation_score.should == 4
    end
    
    it "should not recommend products that user has already rated" do                                                            
      user_x = Factory :user
      similiar_friend = Factory :user
      product = Factory :product
      Factory :rating, :user => user_x,         :stars => 4, :product => product
      Factory :rating, :user => similiar_friend, :stars => 4, :product => product
      Recommender::ProfileBased.should_receive(:similar_users).with(user_x).and_yield(similiar_friend,0.5)
      Recommender::ProfileBased.recommendations_for(user_x).should_not include(product)   
    end
    
  end

  it "should make item based recommendations"

  it "should make trust based recommendations"

end
