require File.dirname(__FILE__) + '/../spec_helper'
 
describe UsersController do
  integrate_views
  
  before(:each) do
    @controller.stub(:admin_signed_in?, false)
    @controller.stub(:user_signed_in?, false)
  end
  
  it "show action should render show template" do
    @user = Factory.stub :user
    User.should_receive(:find).with("2").once.and_return(@user)
    get :show, :id => 2
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    @user = mock_model User, Factory.attributes_for(:user)
    User.should_receive(:new).once.and_return(@user)
    @user.should_receive(:save).and_return(false)   
    @user.stub!(:invitation_token,'aaa')
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do 
    @user = mock_model User
    User.should_receive(:new).and_return(@user)
    @user.should_receive(:save).and_return(true)
    post :create
    response.should redirect_to(user_url(assigns[:user]))
  end
  
end
