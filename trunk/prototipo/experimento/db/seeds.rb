# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
                                
Stage.create_all
['Grazi','Bruna','Machupichu','Saphyra','Daniela','Renato','Luiz','Rafael', 'Diego Esteves', 'Fernando Takey', 'Silvia Takey']. each do |name|
  Group.create! :name => name
end
