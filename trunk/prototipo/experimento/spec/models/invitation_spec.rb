require File.dirname(__FILE__) + '/../spec_helper'

describe Invitation do  
  
  before(:each) do
    @valid_attributes = {
      :recipient_email => "valid@email.com",
      :token => Digest::SHA1.hexdigest('blablabla'),
      :sent_at => Time.at(0),
    }
  end
  
  it "should be valid" do
    Invitation.new(@valid_attributes).should be_valid
  end  
  
end
