require File.dirname(__FILE__) + '/../spec_helper'
 
describe FriendshipsController do
  #fixtures :all
  #integrate_views
  before :each do
    #@friendship = mock_model Friendship                     
    #@friendships = mock_model Array
    #@friendships.stub(:build).with(:friend_id => params[:friend_id]).and_return(@friendship)
    #@current_user.stub(:friendships).and_return(@friendships) 
    #@user_session = mock_model(UserSession)
    #UserSession.stub!(:find).and_return(@user_session)
    #@user_session.stub!(:user).and_return(@current_user)
    #@current_user.stub(:id).and_return(1)  
    @user_session = mock_model(UserSession)     
    @friendships = mock_model Array
    @user = mock_model(User,{:friendships => @friendships, :id => '12'})
    UserSession.stub!(:find).and_return(@user_session)
    @user_session.stub!(:user).and_return(@user)
  end
  
  it "create action should render new template when model is invalid" do  
    @friendships.stub!(:build).with(:friend_id => params[:friend_id]).and_return(@friendship)
    @friendship.stub!(:save).and_return(false)
    
    post :create
    response.should redirect_to(root_url)
  end
  
  it "create action should redirect when model is valid" do
    @friendships.stub!(:build).with(:friend_id => params[:friend_id]).and_return(@friendship)
    @friendship.stub!(:save).and_return(true) 
    post :create
    response.should redirect_to(root_url)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    @friendships.stub(:find).with('12').and_return(@friendship)
    @friendship.stub(:destroy)
    delete :destroy, :id => '12' 
    response.should redirect_to(user_url('12'))
  end   
  
end
