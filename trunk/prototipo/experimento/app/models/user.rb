class User < ActiveRecord::Base     

  ajaxful_rater  
  has_many :rates

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
  validates_presence_of :stage_number
  belongs_to :invitation

  attr_accessible :email, :name, :password, :password_confirmation, :invitation_token,
  :age_group, :sex

  def stage
    Stage.find_by_number!(stage_number)
  end

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end             

  before_validation_on_create { |user| user.stage_number = 1}

  def stage_progress
    case stage_number
      when 1 
        selection = Product.selected 
        rates_from_selection = Rate.all(:conditions => {:user_id => self, :rateable_id => Product.selected}).map(&:rateable)
        return "#{rates_from_selection.count}/#{selection.count}" 
      when 2                    
        rate_count = Rate.count(:conditions => {:user_id => self, :rateable_id => Product.not_selected})
        return "#{rate_count}/10"
    end
    "?/?"
  end

  def completed_stage?
    return self.rates.count > 0 && (Product.selected - Rate.all(:conditions => {:user_id => self, :rateable_id => Product.selected}).map(&:rateable)).empty? if stage_number == 1 
    return Rate.count(:conditions => {:user_id => self, :rateable_id => Product.not_selected}) >= 10 if stage_number == 2
    false
  end

  def advance_stage
    self.update_attribute :stage_number, stage_number + 1
  end

end
