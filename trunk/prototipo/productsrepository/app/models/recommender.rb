module Recommender        
  
  module HashBased

  # Euclidean distance    
  def self.sim_distance(prefs, user1, user2)
    return 0 unless prefs[user1]

    items = prefs[user1].reject do |key,value| 
      prefs[user2][key].nil?
    end.keys

    return 0 if items.length == 0

    sum_of_squares = items.sum do |item|
      ((prefs[user1][item] || 0.0) - (prefs[user2][item] || 0.0)) ** 2
    end

    return 1.0/(1.0 + sum_of_squares)
  end 

  # Pearson score
  def self.sim_pearson(prefs, user1, user2) 
    return 0 unless prefs[user1] and prefs[user2]

    items = prefs[user1].keys & prefs[user2].keys

    return 0 if items.length == 0

    sum1 = sum2 = sum1Sq = sum2Sq = pSum = 0.0

    items.each do |item|
      prefs1_item = prefs[user1][item].to_f || 0.0
      prefs2_item = prefs[user2][item].to_f || 0.0
      sum1   += prefs1_item
      sum2   += prefs2_item
      sum1Sq += prefs1_item ** 2
      sum2Sq += prefs2_item ** 2
      pSum   += prefs2_item * prefs1_item
    end

    num = pSum - ( ( sum1 * sum2 ) / items.length )
    den = Math.sqrt( ( sum1Sq - ( sum1 ** 2 ) / items.length ) * ( sum2Sq - ( sum2 ** 2 ) / items.length ) )

    return 0 if den == 0

    num / den
  end  

  # Returns the best matches for user from the prefs dictionary. 
  # Number of results and similarity function are optional params.
  def self.top_matches(prefs,user,options = {})   
    scores = []          
    defaults = {
      :algorithm      => :sim_pearson,
      :limit          => 5    
    }

    options = defaults.merge(options)
      
    prefs.keys.each do |other|
      # don't compare me to myself
      next if other == user

      score = self.__send__(options[:algorithm], prefs, user, other) 

      # ignore scores of zero or lower
      next if score <= 0

      scores << [score,other]
    end
    scores.sort{|x,y| y <=> x }[0,options[:limit]]
  end 

  # Gets recommendations for a person by using a weighted average 
  # of every other user's rankings 
  def self.recommendations(prefs,user,options = {})
    defaults = {
      :algorithm      => :sim_pearson,
      :limit          => 5    
    }

    options = defaults.merge(options)
    totals={}
    simSums={}      

    prefs.each do |other,ratings|   
      # don't compare me to myself 
      next if other == user
      sim = self.__send__(options[:algorithm], prefs, user, other)    
      # ignore scores of zero or lower 
      next if sim <=0
      prefs[other].keys.each do |item| 
       
        # only score movies I haven't seen yet 
        if (not prefs[user].include?(item)) or prefs[user][item]==0 
          # Similarity * Score   
          totals[item] ||= 0
          totals[item] += (prefs[other][item] || 0.0)*sim 
          # Sum of similarities
          simSums[item] ||= 0 
          simSums[item] += sim 
        end
      end                   
    end         
    rankings = []       
    # Create the normalized list  
    totals.each do |item,total|     
      rankings << [(total/simSums[item]),item]
    end
    # Return the sorted list 
    rankings.sort{|x,y| y <=> x } [0,options[:limit]]
  end   
  
  def self.transform_prefs(prefs) 
    result={} 
    prefs.keys.each do |person|
      prefs[person].keys.each do |item| 
        result[item] ||= {} 
        # Flip item and person 
        result[item][person]=prefs[person][item]
      end
    end 
    result
  end  
  
  def self.calculate_similar_items(prefs,options) 
    defaults = {
      :algorithm      => :sim_pearson,
      :limit          => 10    
    }

    options = defaults.merge(options)
    # Create a dictionary of items showing which other items they 
    # are most similar to. 
    result={} 
    # Invert the preference matrix to be item-centric 
    item_prefs = transform_prefs(prefs) 
    c=0 
    item_prefs.keys.each do |item|
      # Status updates for large datasets 
      c+=1 
      print("%d / %d", [c,item_prefs.length]) if c % 100==0
      # Find the most similar items to this one 
      scores = top_matches(item_prefs,item,options) 
      result[item] = scores 
    end
    result        
  end
  
  def self.item_based_recomendations(prefs,itemMatch,user) 
    userRatings=prefs[user] 
    scores={}
    scores.default = 0 
    totalSim={} 
    totalSim.default = 0
    # Loop over items rated by this user 
    userRatings.each_pair do |item,rating|
      # Loop over items similar to this one 
      itemMatch[item].each do |array|  
        item2 = array[1]
        similarity = array[0]
        # Ignore if this user has already rated this item 
        next if userRatings.include?(item2)
        # Weighted sum of rating times similarity 
        scores[item2] += similarity*rating 
        # Sum of all the similarities 
        totalSim[item2] += similarity 
      end
    end
    # Divide each total score by total weighting to get an average 
    rankings = []
    scores.each_pair do |item,score|
      rankings << [score/totalSim[item],item]
    end
    # Return the rankings from highest to lowest 
    rankings.sort{|x,y| y <=> x }
  end 
  
  end
  
  module ActiveRecordBased
      # Pearson score correlation for ActiveRecord models
    def self.sim_pearson(user1, user2)
      #defaults = {
      #  :item => :item, :through => :reviews, :score => :score
      #}

      #options = defaults.merge(options) 

      items = user1.products & user2.products
       

      return 0 if items.length == 0

      sum1 = sum2 = sum1Sq = sum2Sq = pSum = 0.0

      user1_reviews = user1.reviews.find_all_by_product_id(items)
      user2_reviews = user2.reviews.find_all_by_product_id(items) 
      
      [user1_reviews,user2_reviews].each do |array|
        def array.map_to_hash
          map { |review| { review.product => review.rating } }.inject({}) { |carry, e| carry.merge! e }
        end      
      end  
      prefs_user1 = user1_reviews.map_to_hash
      prefs_user2 = user2_reviews.map_to_hash
       
      items.each do |item|
        prefs1_item = prefs_user1[item]
        prefs2_item = prefs_user2[item] 
        sum1   += prefs1_item
        sum2   += prefs2_item
        sum1Sq += prefs1_item ** 2
        sum2Sq += prefs2_item ** 2
        pSum   += prefs2_item * prefs1_item
      end

      num = pSum - ( ( sum1 * sum2 ) / items.length )
      den = Math.sqrt( ( sum1Sq - ( sum1 ** 2 ) / items.length ) * ( sum2Sq - ( sum2 ** 2 ) / items.length ) )

      return 0 if den == 0

      num / den
    end 
    
    # Returns the best matches for user from the prefs dictionary. 
    # Number of results and similarity function are optional params.
    def self.top_matches(user,options = {})   
      matches = []          
      defaults = {
        :algorithm      => :sim_pearson,
        :limit          => 5    
      }

      options = defaults.merge(options)

      User.all.each do |other|
        # don't compare me to myself
        next if other == user

        score = self.__send__(options[:algorithm], user, other) 

        # ignore scores of zero or lower
        next if score <= 0
                         
        def other.similarity_score; @similarity_score; end
        def other.similarity_score=(d); @similarity_score = d; end
        other.similarity_score = score
        matches << other
      end
      matches.sort{|x,y| y.similarity_score <=> x.similarity_score }[0,options[:limit]]
    end  
    
    # Gets recommendations for a person by using a weighted average 
    # of every other user's rankings 
    def self.recommendations(user,options = {})
      defaults = {
        :algorithm      => :sim_pearson,
        :limit          => 5    
      }

      options = defaults.merge(options)
      totals={}
      simSums={}      
      
      User.all(:include => :reviews).each do |other|
           
        # don't compare me to myself 
        next if other == user
        sim = self.__send__(options[:algorithm], user, other) 
        # ignore scores of zero or lower 
        next if sim <=0
        other.products.each do |item| 
           
          # only score movies I haven't seen yet   
          if (not user.products.include?(item)) #or user.reviews.find_first_by_product(item).rating ==0 
            
            # Similarity * Score   
            totals[item] ||= 0     
            review = Review.find(:first,:conditions => {:user_id => other, :product_id => item} )
            totals[item] += (review.nil? ? 0.0 : review.rating)*sim 
            # Sum of similarities
            simSums[item] ||= 0 
            simSums[item] += sim 
          end
        end                   
      end         
      rankings = []       
      # Create the normalized list  
      totals.each do |item,total|
        def item.recommendation_score; @recommendation_score ; end;
        def item.recommendation_score=(d);  @recommendation_score = d ; end; 
        item.recommendation_score =  (total/simSums[item])
        rankings << item
      end
      # Return the sorted list 
      rankings.sort{|x,y| y.recommendation_score <=> x.recommendation_score } [0,options[:limit]]
    end
    
  end

end