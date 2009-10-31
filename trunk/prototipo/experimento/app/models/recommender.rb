class Recommender 
  class << self                

    def pearson_correlation(x,y)
      intersection = x.rated_products & y.rated_products
      n = intersection.length
      return 0.0 if n == 0

      sum_x = sum_y = sum_x_sq = sum_y_sq = p_sum = 0.0                  

      ratings = Rating.find(:all, :conditions => {:user_id => [x,y], :product_id => intersection})
      product_ratings = ratings.inject({}) do |result,rating| 
        result[rating.product_id] ||= {}  
        result[rating.product_id][rating.user_id] = rating.stars.to_f                         
        result
      end
      product_ratings.values.each do |rate|
        sum_x += rate[x.id]
        sum_y += rate[y.id]
        sum_x_sq += (rate[x.id])**2
        sum_y_sq += (rate[y.id])**2
        p_sum += rate[x.id] * rate[y.id] 
      end

      num = p_sum - ((sum_x*sum_y)/n)
      den = Math.sqrt((sum_x_sq - (sum_x ** 2)/n)*(sum_y_sq - (sum_y ** 2)/n))
      return 0.0 if den == 0.0
      num/den
    end
    alias sim_pearson pearson_correlation

  end                                    

  module ProfileBased 

    def self.similar_users(user,options = {})
      defaults = { :min_similarity => 0.0}
      options = defaults.merge(options)
      similar_users = []
      User.all.each do |other|
        next if other == user
        similarity = Recommender.pearson_correlation(user,other)
        next if similarity <= options[:min_similarity]
        similar_users << other
        yield user,similarity if block_given?
      end                     
      similar_users
    end

    def self.recommendations_for(user,options = {})
      defaults = {:limit => 5}
      options = defaults.merge options

      totals  = {}
      totals.default= 0.0
      similarity_sum = {}
      similarity_sum.default= 0.0

      self.similar_users(user) do |other,similarity|                         
        # Isso me parace um workarround de um bug do rails!                        
        ids = user.rated_product_ids.empty? ? false  : user.rated_product_ids
        ratings = Rating.find :all, :conditions => ['user_id = ? and product_id NOT IN (?)',other,ids]
        ratings.each do |rating|
          totals[rating.product_id] += (rating.stars.to_f * similarity)
          similarity_sum[rating.product_id] += similarity
        end
      end
                   

      rankings = []
      totals.each_pair do |product_id,total|
        item = Product.find(product_id)
        def item.recommendation_score; @recommendation_score ; end;
        def item.recommendation_score=(d);  @recommendation_score = d ; end;
        item.recommendation_score =  (total/similarity_sum[product_id])
        rankings << item
      end
      rankings.sort{|x,y| y.recommendation_score <=> x.recommendation_score } [0,options[:limit]]
    end

  end
end
