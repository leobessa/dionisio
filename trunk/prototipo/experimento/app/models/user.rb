class User < ActiveRecord::Base     
  
  has_many :ratings

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
  validates_presence_of :group_id
  belongs_to :invitation
  belongs_to :group

  def friends
    group.users.delete_if { |u| u == self} 
  end

  attr_accessible :email, :name, :password, :password_confirmation, :invitation_token,
  :age_group, :sex, :group

  def stage
    Stage.find_by_number!(stage_number)
  end

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end             

  before_validation_on_create do |user|
    user.stage_number ||= 1
    user.group ||= user.invitation.group
  end     
  
  def rate_for(item)
    rate = Rating.find(:first,:conditions => {:user_id => self, :product_id => item})
    rate ? rate.stars : 0
  end

  def stage_progress
    case stage_number
    when 1 
      selection = Product.selected 
      rates_from_selection = Rating.all(:conditions => {:user_id => self, :product_id => Product.selected}).map(&:product)
      return "#{rates_from_selection.count}/#{selection.count}" 
    when 2                    
      rate_count = Rating.count(:conditions => {:user_id => self, :product_id => Product.not_selected})
      return "#{rate_count}/10"
    end
    "?/?"
  end

  def completed_stage? 
    case stage_number
    when 1
      self.ratings.count > 0 && (Product.selected - Rating.all(:conditions => {:user_id => self, :product_id => Product.selected}).map(&:product)).empty?
    when 2
      Rating.count(:conditions => {:user_id => self, :product_id => Product.not_selected}) >= 10
    when 3           
      friends.count > 1 && friends.inject(true) { |result,friend| result &&= UserRecommendation.count(:conditions => {:sender_id => self, :target_id => friend }) >= 5 }
    else
      false
    end
  end

  def advance_stage
    self.update_attribute :stage_number, stage_number + 1
  end

  def recommend(options)
    UserRecommendation.create!(options.merge!(:sender => self))
  end
  
  def can_rate?
    [1,2,5,6].include? stage_number 
  end

end
