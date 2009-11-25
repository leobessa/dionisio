namespace :dionisio do
  
  task :destroy_all => :environment do
    SystemRecommendation.destroy_all
  end

  namespace :profile do
    desc "Displays users profile correlation"
    task :similiar_users => :environment do
      User.all.each do |u|
        p "---- #{u.email} (#{u.id})"
        Recommender::ProfileBased.similar_users(u) do |other,similarity|
          p "#{u.email} (#{other.id}) => #{similarity}"
        end
      end
    end

    desc "Builds profile based recommendations"
    task :build => :environment do
      User.all.each do |u|
        Recommender::ProfileBased.recommendations_for(u).each do |r|
          p(r)
        end
      end
    end

    desc "Create profile based recommendations"
    task :create => :environment do
      User.all.each do |u|
        Recommender::ProfileBased.recommendations_for(u).each do |r|
          p(r)
          SystemRecommendation.create!(r)
        end
      end
    end
  end

  namespace :trust do
    desc "Builds trust based recommendations"
    task :build => :environment do
      User.all.each do |u|
        Recommender::TrustBased.recommendations_for(u).each do |r|
          p(r)
        end
      end
    end
    desc "Create trust based recommendations"
    task :create => :environment do
      User.all.each do |u|
        Recommender::TrustBased.recommendations_for(u).each do |r|
          p(r)
          SystemRecommendation.create!(r)
        end
      end
    end
  end

  namespace :trust do
    desc "Builds trust based recommendations"
    task :build => :environment do
      Rails.cache.delete_matched /products_sim_distance/
      User.all.each do |u|
        Recommender::ItemBased.recommendations_for(u).each do |r|
          p(r)
        end
      end
      Rails.cache.delete_matched /products_sim_distance/
    end

    desc "Creates trust based recommendations"
    task :create => :environment do
      Rails.cache.delete_matched /products_sim_distance/
      User.all.each do |u|
        Recommender::ItemBased.recommendations_for(u).each do |r|
          p(r)
          SystemRecommendation.create!(r)
        end
      end
      Rails.cache.delete_matched /products_sim_distance/
    end
  end

end