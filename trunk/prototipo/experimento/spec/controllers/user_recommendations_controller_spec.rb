require File.dirname(__FILE__) + '/../spec_helper'
 
describe UserRecommendationsController do

  before(:each) do                               
    @controller.should_receive(:authenticate_user!).and_return(true)
    @controller.stub(:admin_signed_in?, false)
    @controller.stub(:user_signed_in?, true)
  end
    
  it "new action should render new template" do
    @user = Factory.stub :user
    User.should_receive(:find).with("3").and_return(@user)
    get :new, :user_id => 3
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    @current_user = mock_model User, :stage_number => 3 
    @controller.should_receive(:current_user).and_return(@current_user)
    @user = Factory.stub :user
    User.should_receive(:find).with("3").and_return(@user)
    UserRecommendation.any_instance.stubs(:valid?).returns(false)
    post :create, :user_id => 3
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    @current_user = mock_model User, :stage_number => 3 
    @controller.should_receive(:current_user).and_return(@current_user)
    @user = Factory.stub :user
    User.should_receive(:find).with("3").and_return(@user)
    UserRecommendation.any_instance.stubs(:valid?).returns(true)
    post :create, :user_id => 3
    response.should redirect_to(root_url)
  end
end
