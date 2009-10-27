require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do 
  
  before(:each) do
    @valid_user = Factory :user
  end

  it "should create a new instance given valid attributes" do
    @valid_user.should be_valid
  end 
  
  [:age_group,:sex,:name,:email,:invitation_id,:stage_number].each do |attribute|
    it "should validate presence #{attribute}" do
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
        product.rate(4, @user, '')
      end
      @user.completed_stage?.should == false
      last.rate(4, @user, '')
      @user.completed_stage?.should == true
    end
  end 
  
  
end
