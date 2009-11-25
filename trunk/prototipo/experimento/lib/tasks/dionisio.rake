namespace :dionisio do
  
  desc "Displays users profile correlation"
  task :similar_profiles => :environment do
    User.all.each do |u|
      p "---- #{u.email} (#{u.id})"
      Recommender::ProfileBased.similar_users(u) do |other,similarity|
        p "#{u.email} (#{other.id}) => #{similarity}"
      end
    end
  end
  
  desc "Builds profile based recommendations"
  task :profile => :environment do
    User.all.each do |u|
      Recommender::ProfileBased.recommendations_for(u).each do |r|
         p(r)
         SystemRecommendation.create!(r)
      end
    end
  end
  
  desc "Builds trust based recommendations"
  task :trust => :environment do
    User.all.each do |u|
      Recommender::TrustBased.recommendations_for(u).each do |r|
         p(r)
         SystemRecommendation.create!(r)
      end
    end
  end
  
  desc "Builds trust based recommendations"
  task :item => :environment do
    Rails.cache.delete_matched /products_sim_distance/
    User.all.each do |u|
      Recommender::ItemBased.recommendations_for(u).each do |r|
         p(r)
         SystemRecommendation.create!(r)
      end
    end
    Rails.cache.delete_matched /products_sim_distance/
  end
  
  desc "Builds all recommendations"
  task :all => [:profile, :trust, :item]
  
end