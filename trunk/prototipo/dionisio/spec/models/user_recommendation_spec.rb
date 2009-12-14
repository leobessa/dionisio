require File.dirname(__FILE__) + '/../spec_helper'

describe UserRecommendation do
  it "should be valid" do
    UserRecommendation.new.should be_valid
  end
end
