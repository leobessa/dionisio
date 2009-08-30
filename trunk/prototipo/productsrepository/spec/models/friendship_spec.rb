require File.dirname(__FILE__) + '/../spec_helper'

describe Friendship do
  it "should be valid" do
    Friendship.new.should be_valid
  end
end
