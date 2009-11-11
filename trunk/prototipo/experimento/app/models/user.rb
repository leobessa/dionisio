class User < ActiveRecord::Base     

  has_many :ratings

  class << self 
    def age_groups
      ['18 a 25','26 a 30','31 a 40','mais de 40']
    end
  end

  devise :validatable
  validates_presence_of :invitation_id, :name
  validates_uniqueness_of :invitation_id, :message => 'já foi utilizado'
  validates_inclusion_of :age_group, :in => User.age_groups  
  validates_inclusion_of :sex, :in => %w(M F)  
  validates_presence_of :stage_number
  validates_presence_of :group_id
  belongs_to :invitation
  belongs_to :group
  has_many :rated_products, :through => :ratings, :source => :product                    

  def recommenders
    recommender_ids = UserRecommendation.find(:all,:select => 'DISTINCT sender_id',:conditions => {:target_id => self})
    User.find(recommender_ids.map(&:sender_id))
  end

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

  def unrated_products
    Product.find(:all,:conditions => ['id NOT IN (?)',rated_products.map(&:id)])
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end             

  before_validation_on_create do |user|
    user.stage_number ||= 1
    user.group ||= user.invitation.group
  end     

  def rate_for(item)  
    id = Product === item ? item.id : item
    rate = Rating.find(:first,:conditions => {:user_id => self.id, :product_id => id})
    rate ? rate.stars : 0
  end 

  def rated?(item)
    Rating.find(:first,:conditions => {:user_id => self.id, :product_id => item.id})
  end 

  def recommended?(product,target)
    UserRecommendation.find(:first,:conditions => {:sender_id => self.id, :target_id => target.id, :product_id => product.id })
  end

  def stage_progress
    case stage_number
    when 1 
      rates_count = Rating.count(:joins => :product, :conditions => {:user_id => self, :products => {:selected => true}, :unknown => [true,false]})
    when 2                    
      rate_count = Rating.count(:joins => :product, :conditions => {:user_id => self, :products => {:selected => false}, :unknown => [true,false]})
    when 3                    
      i = friends.sum do |friend|
        s = recommendations_count_to(friend); 
        s = s > 5 ? 5 : s                
      end
    end
  end

  def recommendations_count_to(user)
    UserRecommendation.count(:conditions => {:sender_id => self, :target_id => user})
  end

  def completed_stage? 
    stage_progress >= stage_limit
  end 

  def stage_limit 
    case stage_number
    when 1
      20
    when 2
      10
    when 3           
      20
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
