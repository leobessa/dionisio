require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do 

  before(:each) do
    @valid_user = Factory :user
  end

  it "should create a new instance given valid attributes" do
    @valid_user.should be_valid
  end 

  [:age_group,:sex,:name,:email,:invitation_id,:stage_number,:group_id].each do |attribute|
    it "should validate presence of #{attribute}" do
      @valid_user.send("#{attribute}=",nil)
      @valid_user.should_not be_valid
      @valid_user.should have(1).error_on(attribute)
    end
  end 

  { 1 => 20, 2 => 10 }.each_pair do |stage_number,limit| 
    it "should tell the stage limit is #{limit} when the stage is #{stage_number}" do
      user = Factory.build :user, :stage_number => stage_number
      user.stage_limit.should == limit
    end 
  end

  context "in stage 5" do
    it "should tell the limit is the number of unique recommended products" do
      user = Factory :user, :stage_number => 5
      other = Factory :user, :stage_number => 5
      ur = Factory :user_recommendation, :target => other
      user.stage_limit.should == 0
      friend = Factory :user, :stage_number => 5, :group => user.group
      stranger = Factory :user, :stage_number => 5 
      ur = Factory :user_recommendation, :target => user, :sender => friend
      user.stage_limit.should == 1
      ur = Factory :user_recommendation, :target => user, :sender => stranger
      user.stage_limit.should == 2
      Factory :user_recommendation, :target => user, :sender => friend, :product => ur.product
      user.stage_limit.should == 2
    end

    it "should tell the progess is the number of rated products that have been recommended" do
      user = Factory :user, :stage_number => 5
      user.stage_progress.should == 0
      friend = Factory :user, :stage_number => 5, :group => user.group
      ur = Factory :user_recommendation, :target => user, :sender => friend
      Rating.create :user => user
      user.stage_progress.should == 0
      r = Rating.create :user => user, :product => ur.product, :unknown => nil
      user.stage_progress.should == 0
      r.update_attribute :unknown, true  
      user.stage_progress.should == 1
      ur = Factory :user_recommendation, :target => user
      user.stage_progress.should == 1
      Rating.create :user => user, :product => ur.product, :unknown => false 
      user.stage_progress.should == 2
    end
  end

  context "in stage 6" do
    it "should tell the limit is the number of unique recommended products" do
      user = Factory :user, :stage_number => 6
      user.stage_limit.should == 0
      a = Factory :system_recommendation, :user => user, :algorithm => 'profile'
      user.stage_limit.should == 1
      Factory :system_recommendation, :user => user, :product => a.product, :algorithm => 'item'
      user.stage_limit.should == 1
      Factory :system_recommendation, :user => user
      user.stage_limit.should == 2
      Factory :user_recommendation
      user.stage_limit.should == 2
    end

    it "should tell the progess is the number of rated products that have been recommended" do
      user = Factory :user, :stage_number => 6
      user.stage_progress.should == 0
      a = Factory :system_recommendation, :user => user, :algorithm => 'profile'
      Rating.create :user => user
      user.stage_progress.should == 0
      r = Rating.create :user => user, :product => a.product, :unknown => nil
      user.stage_progress.should == 0
      r.update_attribute :unknown, true  
      user.stage_progress.should == 1
      sr = Factory :system_recommendation, :user => user
      user.stage_progress.should == 1
      Rating.create :user => user, :product => sr.product, :unknown => false 
      user.stage_progress.should == 2
    end
  end

  it "should tell the stage limit is 5*friends when the stage is 3" do
    user = Factory.create :user, :stage_number => 3
    3.times { Factory.create :user, :stage_number => 3, :group => user.group }
    user.stage_limit.should == 15
  end

  it "should set stage_number to 1 before creating" do
    user = Factory.build :user, :stage_number => nil
    user.save
    user.stage_number.should == 1
  end

  context "when user is in stage 1" do   

    it "should tell when the stage has been completed" do
      @user = Factory :user, :stage_number => 1
      @user.completed_stage?.should == false 
      20.times { Factory :product, :selected => true}
      20.times { Factory :product, :selected => false}
      selection = Product.selected
      19.times do
        Rating.create!(:stars => 4, :user => @user, :product => selection.pop, :unknown => false)
      end
      @user.completed_stage?.should == false 
      Rating.create!(:stars => 4, :user => @user, :product => selection.pop, :unknown => true)
      @user.completed_stage?.should == true 
    end
  end

  context "when user is in stage 2" do 
    it "should tell when the stage has been completed" do
      @user = Factory :user
      @user.update_attribute :stage_number, 2
      @user.completed_stage?.should == false 
      10.times { Factory :product, :selected => false}
      selection = Product.find :all, :conditions => {:selected => false}
      9.times do 
        Rating.create!(:stars => 4, :user => @user, :product => selection.pop, :unknown => true)
      end
      @user.completed_stage?.should == false
      Rating.create!(:stars => 4, :user => @user, :product => selection.pop, :unknown => false)
      @user.completed_stage?.should == true 
    end

  end  

  context "when user is in stage 3" do 
    context "and has 4 friends" do
      it "should tell when the stage has been completed" do
        @poli  = Factory :group
        @user1 = Factory :user, :group => @poli, :stage_number => 3  
        @user2 = Factory :user, :group => @poli, :stage_number => 3
        @user3 = Factory :user, :group => @poli, :stage_number => 4
        @user4 = Factory :user, :group => @poli, :stage_number => 3
        @user5 = Factory :user, :group => @poli, :stage_number => 4
        @user1.completed_stage?.should == false
        @user1.friends.each do |friend|
          5.times { @user1.recommend(:target => friend, :product => (Factory :product) ) }
        end      
        @user1.completed_stage?.should == true  
      end
    end

    context "and has no friends" do 
      it "should tell when the stage has been completed" do
        @poli  = Factory :group
        @user1 = Factory :user, :group => @poli, :stage_number => 3
        Factory :user, :group => @poli, :stage_number => 3  
        @user1.completed_stage?.should == false              
      end
    end 

  end 

  context "when user is in stage 2" do     
    context "ratings don't have unknown set" do
      it "should tell the stage progress is 0" do
        @user = Factory :user, :stage_number => 2
        @user.stage_progress.should == 0           
        10.times { Factory :product, :selected => false}
        Rating.create!(:stars => 4, :user => @user, :product => Product.selected.first)
        @user.stage_progress.should == 0
      end   
    end
    context "ratings do have unknown set" do
      it "should tell the correct stage progress" do
        @user = Factory :user, :stage_number => 2
        @user.stage_progress.should == 0           
        10.times { Factory :product, :selected => false}
        selection = Product.find :all, :conditions => {:selected => false}
        9.times { Rating.create!(:stars => 4, :user => @user, :product => selection.pop, :unknown => false )}
        @user.stage_progress.should == 9 
        Rating.create!(:stars => 4, :user => @user, :product => selection.pop, :unknown => false)
        @user.stage_progress.should == 10
      end   
    end
  end 

  it "should be able to have a group of friends" do
    @poli = Factory :group, :name => 'Poli'
    @fools = Factory :group, :name => 'Fools'
    @leo = Factory :user, :group => @poli
    @rato = Factory :user, :group => @poli
    @allan = Factory :user, :group => @poli 
    @fool = Factory :user, :group => @fools 
    @leo.friends.should include(@rato)
    @leo.friends.should include(@allan)   
    @leo.friends.should_not include(@leo), :messsage => ' User should not be his/her own friend'
    @leo.friends.should_not include(@fool)
  end

end
