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

  context "finding items similarity" do

    it "should be zero when no one has rated both items" do
      a = Factory :product
      b = Factory :product
      Recommender.sim_distance(a,b).should == 0.0
    end

    it "should be the 0.5 when just one user has rated a item with 5 and other with 4" do
      a = Factory :rating, :stars => 5
      b = Factory :rating, :stars => 4, :user => a.user
      Recommender.sim_distance(a.product,b.product).should == 0.5
    end

    it "should be the 1/26 with (hint: 1 + 3ˆ2 + 4ˆ2 = 26)" do
      m = Factory :product
      n = Factory :product
      a = Factory :rating, :stars => 5, :product => m
      b = Factory :rating, :stars => 1, :product => n, :user => a.user
      c = Factory :rating, :stars => 2, :product => m
      d = Factory :rating, :stars => 5, :product => n, :user => c.user
      Recommender.sim_distance(m,n).should == 1.0/26.0
    end

    it "should ignore other product rating if user rated only one product" do
      m = Factory :product
      n = Factory :product
      a = Factory :rating, :stars => 5, :product => m
      b = Factory :rating, :stars => 1, :product => n, :user => a.user
      c = Factory :rating, :stars => 2, :product => m
      Recommender.sim_distance(m,n).should == 1.0/17.0
    end

    it "should be the 1 when all users give the same ratings for both" do
      m = Factory :product
      n = Factory :product                                            
      3.times { Factory :user}
      stars = 1
      User.all.each do |rater|  
        Factory :rating, :stars => stars, :product => m, :user => rater
        Factory :rating, :stars => stars, :product => n, :user => rater
        stars += 1
      end 
      Recommender.sim_distance(m,n).should == 1.0
    end

    it "should work with ids if integers are passed as arguments" do
      m = Factory :product
      n = Factory :product                                            
      3.times { Factory :user}
      stars = 1
      User.all.each do |rater|  
        Factory :rating, :stars => stars, :product => m, :user => rater
        Factory :rating, :stars => stars, :product => n, :user => rater
        stars += 1
      end
      Recommender.sim_distance(m.id,n.id).should == 1.0
    end

  end

  context "making item based recommendations" do
    it "should be none if user has rated no products" do
      user = Factory :user
      Recommender::ItemBased.recommendations_for(user).should be_empty
    end

    it "should be based on products that are similar to the ones the user has rated" do 
      product                = Factory :product
      similar                = Factory :product
      user                   = Factory :user
      Factory :rating, :product => product, :stars => 4, :user => user
      Factory :rating, :product => similar, :stars => 4

      Recommender.should_receive(:sim_distance).with(product.id,similar.id).and_return(0.8)
      recommendations = Recommender::ItemBased.recommendations_for(user)
      recommendations.should include(similar)                           
      recommendations.length.should == 1
      recommendations.first.recommendation_score.should == 4
    end

    it "should be weighted by product similarity" do
      rated_product_1        = Factory :product
      rated_product_2        = Factory :product
      similar                = Factory :product
      user                   = Factory :user   

      Factory :rating, :product => rated_product_1, :stars => 2, :user => user
      Factory :rating, :product => rated_product_2, :stars => 5, :user => user
      Factory :rating, :product => similar

      Recommender.should_receive(:sim_distance).with(rated_product_1.id,similar.id).and_return(0.8)
      Recommender.should_receive(:sim_distance).with(rated_product_2.id,similar.id).and_return(0.9)
      recommendations = Recommender::ItemBased.recommendations_for(user)
      recommendations.should include(similar)
      recommendations.length.should == 1
      recommendations.first.recommendation_score.should be_close(3.588,0.001)
    end 

    it "should bring recommendations ordered by score" do
      rated_product_1        = Factory :product
      rated_product_2        = Factory :product
      similar_2              = Factory :product
      similar_1              = Factory :product
      user                   = Factory :user   

      Factory :rating, :product => rated_product_1, :stars => 2, :user => user
      Factory :rating, :product => rated_product_2, :stars => 5, :user => user
      Factory :rating, :product => similar_2
      Factory :rating, :product => similar_1

      Recommender.should_receive(:sim_distance).with(rated_product_1.id,similar_1.id).and_return(0.8)
      Recommender.should_receive(:sim_distance).with(rated_product_2.id,similar_1.id).and_return(0.9)
      Recommender.should_receive(:sim_distance).with(rated_product_1.id,similar_2.id).and_return(0.5)
      Recommender.should_receive(:sim_distance).with(rated_product_2.id,similar_2.id).and_return(0.2)
      recommendations = Recommender::ItemBased.recommendations_for(user)
      recommendations.length.should == 2
      first = recommendations.first
      second = recommendations.second
      first.id.should be(similar_1.id)
      first.recommendation_score.should be_close(3.588,0.001)
      second.id.should be(similar_2.id)
      second.recommendation_score.should be_close(2.857,0.001)
    end

  end

  it "should make trust based recommendations"

end
