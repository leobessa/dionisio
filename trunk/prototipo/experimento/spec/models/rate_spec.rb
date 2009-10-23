require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rate do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :rateable_id => 1,
      :rateable_type => "value for rateable_type",
      :stars => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Rate.create!(@valid_attributes)
  end
end
