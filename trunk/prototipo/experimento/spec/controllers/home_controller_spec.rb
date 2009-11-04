require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do

  context "user has signed in" do
    before(:each) do                               
      @controller.should_receive(:authenticate_user!).and_return(true)
      @controller.stub(:admin_signed_in?, false)
      @controller.stub(:user_signed_in?, true)
      @controller.should_receive(:check_stage_avaiability).and_return(true)
    end


    describe "GET 'index'" do
      it "should be successful" do                 
        @user = mock_model User, :stage_number => 1
        @controller.should_receive(:current_user).at_least(1).and_return(@user)
        get 'index'
        response.should be_success
      end
    end 

  end

end
