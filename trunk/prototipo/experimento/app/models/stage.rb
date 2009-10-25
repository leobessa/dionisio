class Stage < ActiveRecord::Base
  validates_uniqueness_of :number

  def self.create_all
    for number in 1..5 do
      create(:number => number, :enabled => (number == 1)) 
    end
  end                

end
