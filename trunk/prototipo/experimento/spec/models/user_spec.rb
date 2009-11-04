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

  it "should set stage_number to 1 before creating" do
    user = Factory.build :user, :stage_number => nil
    user.save
    user.stage_number.should == 1
  end

  it "should tell when the stage has been completed" do 

    context "when user is in stage 1" do
      @user = Factory :user, :stage_number => 1
      @user.completed_stage?.should == false 
      20.times { Factory :product, :selected => true}
      20.times { Factory :product, :selected => false}
      selection = Product.selected
      last = selection.pop
      selection.each do |product|
        Rating.create!(:stars => 4, :user => @user, :product => product)
      end
      @user.completed_stage?.should == false 
      Rating.create!(:stars => 4, :user => @user, :product => last)
      @user.completed_stage?.should == true
    end

    context "when user is in stage 2" do
      @user = Factory :user
      @user.update_attribute :stage_number, 2
      @user.completed_stage?.should == false 
      10.times { Factory :product, :selected => false}
      selection = Product.find :all, :conditions => {:selected => false}
      selection[0..8].each do |product|
        Rating.create!(:stars => 4, :user => @user, :product => product)
      end
      @user.completed_stage?.should == false
      Rating.create!(:stars => 4, :user => @user, :product => selection[9])
      @user.completed_stage?.should == true
    end  

    context "when user is in stage 3" do 
      context "and has 4 friends" do
        @poli  = Factory :group
        @user1 = Factory :user, :group => @poli, :stage_number => 3  
        @user2 = Factory :user, :group => @poli
        @user3 = Factory :user, :group => @poli
        @user4 = Factory :user, :group => @poli
        @user5 = Factory :user, :group => @poli
        @user1.completed_stage?.should == false
        @user1.friends.each do |friend|
          5.times { @user1.recommend(:target => friend, :product => (Factory :product) ) }
        end      
        @user1.completed_stage?.should == true 
      end

      context "and has no friends" do
        @poli  = Factory :group
        @user1 = Factory :user, :group => @poli, :stage_number => 3  
        @user1.completed_stage?.should == false
      end 

    end 


  end 

  context "when user is in stage 2" do 
    it "should tell the stage progress" do

      @user = Factory :user, :stage_number => 2
      @user.stage_progress.should == "0/10"           
      10.times { Factory :product, :selected => false}
      selection = Product.find :all, :conditions => {:selected => false}
      selection[0..8].each do |product| 
        Rating.create!(:stars => 4, :user => @user, :product => product)
      end
      @user.stage_progress.should == "9/10" 
      Rating.create!(:stars => 4, :user => @user, :product => selection[9])
      @user.stage_progress.should == "10/10"

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
