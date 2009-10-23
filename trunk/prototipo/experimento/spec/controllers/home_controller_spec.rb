require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do

  context "user has signed in" do
    before(:each) do
      @controller.stub(:admin_signed_in?, false)
      @controller.stub(:user_signed_in?, true)
    end


    describe "GET 'index'" do
      it "should be successful" do
        get 'index'
        response.should be_success
      end
    end 

  end

end
