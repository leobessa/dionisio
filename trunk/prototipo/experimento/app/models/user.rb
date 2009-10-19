class User < ActiveRecord::Base
  devise :recoverable, :validatable
  validates_presence_of :invitation_id, :message => 'is required'
  validates_uniqueness_of :invitation_id, :message => 'já foi utilizado'

  belongs_to :invitation

  attr_accessible :email, :name, :password, :password_confirmation, :invitation_token

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end

end
