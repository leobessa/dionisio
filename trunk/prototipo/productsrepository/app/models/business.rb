class Business < ActiveRecord::Base
  has_many :offers
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_presence_of :url, :on => :create, :message => "can't be blank"
end
