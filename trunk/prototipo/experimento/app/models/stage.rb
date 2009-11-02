class Stage < ActiveRecord::Base
  validates_uniqueness_of :number

  def self.create_all
    for number in 1..6 do
      create(:number => number, :enabled => (number == 1 or number == 2)) 
    end
  end                

end
