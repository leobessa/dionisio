require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Recommender do

  context "finding users similarity" do


    it "should be 0 when intersection is empty" do
      @foo = Factory.create :user
      @boo = Factory.create :user
      Recommender.pearson_correlation(@foo,@boo).should == 0
    end


    it "should be 0 when intersection has 1 item" do
      @foo = Factory.create :user
      @boo = Factory.create :user 
      @product = Factory :product
      Factory :rating, :user => @foo, :product => @product, :stars => 3
      Factory :rating, :user => @boo, :product => @product, :stars => 4
      Recommender.pearson_correlation(@foo,@boo).should be 0
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

  end

  it "should make profile based recommendations"

  it "should make item based recommendations"

  it "should make trust based recommendations"

end
