require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProductController do

  describe "GET 'rate'" do
    it "should be successful" do
      pending
      get 'rate'
      response.should be_success
    end
  end
end
