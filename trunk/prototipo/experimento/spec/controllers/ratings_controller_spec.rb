require File.dirname(__FILE__) + '/../spec_helper'

describe RatingsController do

  before(:each) do
    @controller.stub(:admin_signed_in?, false)
    @controller.stub(:user_signed_in?, false)          
    @controller.should_receive(:authenticate_user!).and_return(true)
  end

  it "index action should render index template" do
    @current_user = mock_model User, :stage_number => 2 
    @controller.stub!(:current_user).and_return(@current_user)
    @user = Factory.stub :user
    User.should_receive(:find).with("3").and_return(@user)
    get :index, :user_id => 3
    response.should render_template(:index)
  end 

end
