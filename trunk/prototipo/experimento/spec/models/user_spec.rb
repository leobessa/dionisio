require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_user = Factory :user
  end

  it "should create a new instance given valid attributes" do
    @valid_user.should be_valid
  end 
  
  [:age_group,:sex,:name,:email,:invitation_id].each do |attribute|
    it "should validate presence #{attribute}" do
        @valid_user.send("#{attribute}=",nil)
        @valid_user.should_not be_valid
        @valid_user.should have(1).error_on(attribute)
      end
  end
end
