class User < ActiveRecord::Base     

  ajaxful_rater  
  
  class << self 
    def age_groups
      ['18 a 25','26 a 30','31 a 40','mais de 40']
    end
  end
    
  devise :recoverable, :validatable
  validates_presence_of :invitation_id, :name
  validates_uniqueness_of :invitation_id, :message => 'já foi utilizado'
  validates_inclusion_of :age_group, :in => User.age_groups  
  validates_inclusion_of :sex, :in => %w(M F)
  belongs_to :invitation
  belongs_to :stage

  attr_accessible :email, :name, :password, :password_confirmation, :invitation_token,
                  :age_group, :sex
                  
  
  def invitation_token
    invitation.token if invitation
  end
  
  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end             
  
  before_create :set_stage_to_one
  def set_stage_to_one
     stage = Stage.find_by_number!(1)
  end

end
