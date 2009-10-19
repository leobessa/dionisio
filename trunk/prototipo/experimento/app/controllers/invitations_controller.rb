class InvitationsController < ApplicationController  
  before_filter :sign_in_admin!                           
  
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    if @invitation.save
        Mailer.deliver_invitation(@invitation, signup_url(@invitation.token))
        flash[:notice] = "Convite enviado para #{@invitation.recipient_email}"
    end
    render :action => 'new'
  end
  
end
