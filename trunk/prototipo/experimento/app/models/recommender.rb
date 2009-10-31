class Recommender                 
  
  def self.pearson_correlation(x,y)
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
    return 0 if den == 0
    num/den
  end 
  
end
