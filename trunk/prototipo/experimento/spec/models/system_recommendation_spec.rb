require 'spec_helper'

describe SystemRecommendation do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :algorithm => "item",
      :product_id => 1,
      :predicted_rating => 1
    }
  end

  it "should create a new instance given valid attributes" do
    SystemRecommendation.create!(@valid_attributes)
  end
end
