require File.dirname(__FILE__) + '/../spec_helper'
 
describe FriendshipsController do
  #fixtures :all
  #integrate_views
  before :each do
    @friendship = mock_model Friendship
  end
  
  it "create action should render new template when model is invalid" do
    Friendship.should_receive(:new).with(params[:friendship]).once.and_return(@friendship) 
    @friendship.stub!(:save).and_return(false)
    
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Friendship.should_receive(:new).with(params[:friendship]).once.and_return(@friendship) 
    @friendship.stub!(:save).and_return(true) 
    post :create
    response.should redirect_to(root_url)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    friendship = Factory :friendship
    delete :destroy, :id => friendship
    response.should redirect_to(root_url)
    Friendship.exists?(friendship.id).should be_false
  end
end
