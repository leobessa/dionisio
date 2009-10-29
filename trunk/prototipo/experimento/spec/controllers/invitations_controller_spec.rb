require File.dirname(__FILE__) + '/../spec_helper'
require 'ostruct'

describe InvitationsController do       

  before(:each) do   
     @attributes = {'recipient_email' => "joe@email.com"}
     @controller.should_receive(:authenticate_admin!).and_return(true)
     @controller.stub(:admin_signed_in?, true)
     @controller.stub(:user_signed_in?, false)
     @invitation = mock_model Invitation, @attributes   
  end

  it "new action should render new template" do
    Invitation.should_receive(:new).with().once.and_return(@invitation)
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do 
    Invitation.should_receive(:new).with(@attributes).once.and_return(@invitation)
    @invitation.should_receive(:save).with().once.and_return(false)
    post :create, :invitation => @attributes
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Invitation.should_receive(:new).with(@attributes).once.and_return(@invitation)
    @invitation.should_receive(:save).once.and_return(true)
    @invitation.should_receive(:token).and_return('01234567')
    Mailer.should_receive(:deliver_invitation).with(@invitation, signup_url('01234567'))
    post :create, :invitation => @attributes
    response.should render_template(:new)
  end
end
