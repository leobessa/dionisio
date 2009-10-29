require File.dirname(__FILE__) + '/../spec_helper'

describe RatingsController do

  before(:each) do
    @controller.stub(:admin_signed_in?, false)
    @controller.stub(:user_signed_in?, false)
  end

  integrate_views

  it "index action should render index template" do
    @user = mock_model User
    User.should_receive(:find).with("3").and_return(@user)
    get :index, :user_id => 3
    response.should render_template(:index)
  end 
  
end
