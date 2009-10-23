require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stage do
  before(:each) do
    @valid_attributes = {
      :number => 1,
      :enabled => false
    }
  end

  it "should create a new instance given valid attributes" do
    Stage.create!(@valid_attributes)
  end
end
