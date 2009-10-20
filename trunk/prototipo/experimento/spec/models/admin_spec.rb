require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Admin do
  before(:each) do
    @valid_admin = Factory :admin
  end

  it "should create a new instance given valid attributes" do
    @valid_admin.should be_valid
  end
end
