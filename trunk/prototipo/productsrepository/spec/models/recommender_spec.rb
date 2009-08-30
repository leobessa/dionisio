require File.dirname(__FILE__) + '/../spec_helper'

describe 'Recommender::HashBased' do  
  
  before :all do
    # A dictionary of movie critics and their ratings of a small 
    # set of movies 
    @critics={'Lisa Rose' => {'Lady in the Water' => 2.5, 'Snakes on a Plane' => 3.5, 
     'Just My Luck' => 3.0, 'Superman Returns' => 3.5, 'You, Me and Dupree' => 2.5, 
     'The Night Listener' => 3.0}, 
    'Gene Seymour' => {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 3.5, 
     'Just My Luck' => 1.5, 'Superman Returns' => 5.0, 'The Night Listener' => 3.0, 
     'You, Me and Dupree' => 3.5}, 
    'Michael Phillips' => {'Lady in the Water' => 2.5, 'Snakes on a Plane' => 3.0, 
     'Superman Returns' => 3.5, 'The Night Listener' => 4.0}, 
    'Claudia Puig' => {'Snakes on a Plane' => 3.5, 'Just My Luck' => 3.0, 
     'The Night Listener' => 4.5, 'Superman Returns' => 4.0, 
     'You, Me and Dupree' => 2.5}, 
    'Mick LaSalle' => {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 4.0, 
     'Just My Luck' => 2.0, 'Superman Returns' => 3.0, 'The Night Listener' => 3.0, 
     'You, Me and Dupree' => 2.0}, 
    'Jack Matthews' => {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 4.0, 
     'The Night Listener' => 3.0, 'Superman Returns' => 5.0, 'You, Me and Dupree' => 3.5}, 
    'Toby' => {'Snakes on a Plane' =>4.5,'You, Me and Dupree' =>1.0,'Superman Returns' =>4.0}}
  end

  it "should flip item and person" do
    input = {'Lisa Rose' => {'Lady in the Water' => 2.5, 'Snakes on a Plane' => 3.5}, 
    'Gene Seymour' => {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 3.5}}
    output = Recommender::HashBased.transform_prefs input
    assert_equal ({'Lady in the Water' => {'Lisa Rose' => 2.5,'Gene Seymour' => 3.0}, 
    'Snakes on a Plane' => {'Lisa Rose' => 3.5, 'Gene Seymour' => 3.5}}), output    
  end  
  
  it "should make item based recommendations" do
    similarity_dataset = Recommender::HashBased.calculate_similar_items @critics, :algorithm  => :sim_distance, :limit => 10  
    expected = [[3.182, 'The Night Listener'], [2.598, 'Just My Luck'],  [2.473, 'Lady in the Water']]
    actual = Recommender::HashBased.item_based_recomendations @critics, similarity_dataset, 'Toby'
    expected.each_with_index do |prediction,index|
      assert_equal actual[index][1], prediction[1]
      assert_in_delta actual[index][0], prediction[0], 0.001
    end   
  end
  
end

describe 'Recommender::HashBased', 'with euclidean distance' do    
  
  before :all do
    # A dictionary of movie critics and their ratings of a small 
    # set of movies 
    @critics={'Lisa Rose' => {'Lady in the Water' => 2.5, 'Snakes on a Plane' => 3.5, 
     'Just My Luck' => 3.0, 'Superman Returns' => 3.5, 'You, Me and Dupree' => 2.5, 
     'The Night Listener' => 3.0}, 
    'Gene Seymour' => {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 3.5, 
     'Just My Luck' => 1.5, 'Superman Returns' => 5.0, 'The Night Listener' => 3.0, 
     'You, Me and Dupree' => 3.5}, 
    'Michael Phillips' => {'Lady in the Water' => 2.5, 'Snakes on a Plane' => 3.0, 
     'Superman Returns' => 3.5, 'The Night Listener' => 4.0}, 
    'Claudia Puig' => {'Snakes on a Plane' => 3.5, 'Just My Luck' => 3.0, 
     'The Night Listener' => 4.5, 'Superman Returns' => 4.0, 
     'You, Me and Dupree' => 2.5}, 
    'Mick LaSalle' => {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 4.0, 
     'Just My Luck' => 2.0, 'Superman Returns' => 3.0, 'The Night Listener' => 3.0, 
     'You, Me and Dupree' => 2.0}, 
    'Jack Matthews' => {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 4.0, 
     'The Night Listener' => 3.0, 'Superman Returns' => 5.0, 'You, Me and Dupree' => 3.5}, 
    'Toby' => {'Snakes on a Plane' =>4.5,'You, Me and Dupree' =>1.0,'Superman Returns' =>4.0}}
  end

  it 'should return a distance-based similarity score for person1 and person2' do    
    prefs = {}
    user1 = 'Joe'
    user2 = 'Leo'
    distance = Recommender::HashBased.sim_distance prefs, user1, user2
    assert_equal 0, distance
    
    distance = Recommender::HashBased.sim_distance(@critics, 'Lisa Rose','Gene Seymour')
    assert_in_delta 0.148148148148, distance, 0.000000001
  end  
  
  it "should get recommendations for a person by using a weighted average of every other user's rankings" do
    euclidean_recommendations = Recommender::HashBased.recommendations @critics, 'Toby', :algorithm  => :sim_distance, :limit => 3
    assert_equal [[3.5002478401415877, 'The Night Listener'], 
    [2.7561242939959363, 'Lady in the Water'], [2.4619884860743739, 'Just My Luck']].to_s, euclidean_recommendations.to_s
  end
  
  it "should create a hash of items showing which other items they are most similar to" do
     similar_items = Recommender::HashBased.calculate_similar_items @critics, :algorithm  => :sim_distance, :limit => 10
     expected = {'Lady in the Water' => 
                  [[0.40000000000000002, 'You, Me and Dupree'],[0.2857142857142857, 'The Night Listener']],
                 'Snakes on a Plane'=> 
                 [[0.22222222222222221, 'Lady in the Water'],[0.18181818181818182, 'The Night Listener']]
                }
     expected.each do |item,results|
       results.each do |pair|
         assert similar_items[item].include?(pair)
       end
     end
  end

end

describe 'Recommender::HashBased', 'with Pearson correlation coefficient' do    
  
  before :all do
    # A dictionary of movie critics and their ratings of a small 
    # set of movies 
    @critics={'Lisa Rose' => {'Lady in the Water' => 2.5, 'Snakes on a Plane' => 3.5, 
     'Just My Luck' => 3.0, 'Superman Returns' => 3.5, 'You, Me and Dupree' => 2.5, 
     'The Night Listener' => 3.0}, 
    'Gene Seymour' => {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 3.5, 
     'Just My Luck' => 1.5, 'Superman Returns' => 5.0, 'The Night Listener' => 3.0, 
     'You, Me and Dupree' => 3.5}, 
    'Michael Phillips' => {'Lady in the Water' => 2.5, 'Snakes on a Plane' => 3.0, 
     'Superman Returns' => 3.5, 'The Night Listener' => 4.0}, 
    'Claudia Puig' => {'Snakes on a Plane' => 3.5, 'Just My Luck' => 3.0, 
     'The Night Listener' => 4.5, 'Superman Returns' => 4.0, 
     'You, Me and Dupree' => 2.5}, 
    'Mick LaSalle' => {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 4.0, 
     'Just My Luck' => 2.0, 'Superman Returns' => 3.0, 'The Night Listener' => 3.0, 
     'You, Me and Dupree' => 2.0}, 
    'Jack Matthews' => {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 4.0, 
     'The Night Listener' => 3.0, 'Superman Returns' => 5.0, 'You, Me and Dupree' => 3.5}, 
    'Toby' => {'Snakes on a Plane' =>4.5,'You, Me and Dupree' =>1.0,'Superman Returns' =>4.0}}
  end
  
  it 'should return the Pearson correlation coefficient for p1 and p2' do
    prefs = {}
    user1 = 'Joe'
    user2 = 'Leo'
    distance = Recommender::HashBased.sim_pearson prefs, user1, user2
    assert_equal 0, distance
    

    distance = Recommender::HashBased.sim_pearson(@critics, 'Lisa Rose','Gene Seymour')
    assert_in_delta 0.396059017191, distance, 0.000000001
  end
  
  it 'should return the best matches for person from the prefs dictionary' do
    top_matches = Recommender::HashBased.top_matches @critics, 'Toby', :algorithm  => :sim_pearson, :limit => 3
    assert_equal top_matches, [[0.99124070716192991, 'Lisa Rose'], [0.92447345164190486, 'Mick LaSalle'], 
     [0.89340514744156474, 'Claudia Puig']]
  end 
  
  it "should gets recommendations for a person by using a weighted average of every other user's rankings" do
    pearson_recommendations = Recommender::HashBased.recommendations @critics, 'Toby', :algorithm  => :sim_pearson, :limit => 3
    assert_equal [[3.3477895267131013, 'The Night Listener'], 
    [2.8325499182641614, 'Lady in the Water'], [2.5309807037655645, 'Just My Luck']].to_s, pearson_recommendations.to_s
  end

end    

describe 'Recommender::ActiveRecord', ' usage by ActiveRecord models' do    
  
  before :all do
    # A dictionary of movie critics and their ratings of a small 
    # set of movies  
    critics={'Lisa Rose' => {'Lady in the Water' => 2.5, 'Snakes on a Plane' => 3.5, 
     'Just My Luck' => 3.0, 'Superman Returns' => 3.5, 'You, Me and Dupree' => 2.5, 
     'The Night Listener' => 3.0}, 
    'Gene Seymour' => {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 3.5, 
     'Just My Luck' => 1.5, 'Superman Returns' => 5.0, 'The Night Listener' => 3.0, 
     'You, Me and Dupree' => 3.5}, 
    'Michael Phillips' => {'Lady in the Water' => 2.5, 'Snakes on a Plane' => 3.0, 
     'Superman Returns' => 3.5, 'The Night Listener' => 4.0}, 
    'Claudia Puig' => {'Snakes on a Plane' => 3.5, 'Just My Luck' => 3.0, 
     'The Night Listener' => 4.5, 'Superman Returns' => 4.0, 
     'You, Me and Dupree' => 2.5}, 
    'Mick LaSalle' => {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 4.0, 
     'Just My Luck' => 2.0, 'Superman Returns' => 3.0, 'The Night Listener' => 3.0, 
     'You, Me and Dupree' => 2.0}, 
    'Jack Matthews' => {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 4.0, 
     'The Night Listener' => 3.0, 'Superman Returns' => 5.0, 'You, Me and Dupree' => 3.5}, 
    'Toby' => {'Snakes on a Plane' =>4.5,'You, Me and Dupree' =>1.0,'Superman Returns' =>4.0}} 
    [User,Review,Product].each(&:destroy_all)
    critics.each do |user_name,reviews|
       user = Factory :user, :username => user_name
       reviews.each do |product_name,rating| 
         product = Product.find_or_create_by_name product_name
         Factory :review, :user => user, :product => product, :rating => rating
       end
     end
  end 
  
  after :all do
    [User,Review,Product].each(&:destroy_all)
  end
  
  it 'should return the Pearson correlation coefficient for p1 and p2' do
    lisa = User.find_by_username 'Lisa Rose'
    gene = User.find_by_username 'Gene Seymour'
    distance = Recommender::ActiveRecordBased.sim_pearson( lisa, gene)
    assert_in_delta 0.396059017191, distance, 0.000000001
  end 
  
  it 'should return the best matches for person from the prefs dictionary' do 
    toby = User.find_by_username 'Toby'
    top_matches = Recommender::ActiveRecordBased.top_matches toby, :algorithm  => :sim_pearson, :limit => 3 
   
    expected = [[0.99124070716192991, 'Lisa Rose'], [0.92447345164190486, 'Mick LaSalle'], 
     [0.89340514744156474, 'Claudia Puig']]
    expected.each_with_index do |a,index|
      score,name = *a     
      user = top_matches[index]
      assert_equal score, user.similarity_score
      assert_equal name,  user.username
    end
      
  end  
  
  it "should get recommendations for a person by using a weighted average of every other user's rankings" do
    toby = User.find_by_username 'Toby' 
    pearson_recommendations = Recommender::ActiveRecordBased.recommendations toby, :algorithm  => :sim_pearson, :limit => 3
    expected = [[3.3477895267131013, 'The Night Listener'], 
    [2.8325499182641614, 'Lady in the Water'], [2.5309807037655645, 'Just My Luck']]
    
    expected.each_with_index do |a,index|
      score,name = *a     
      item = pearson_recommendations[index]
      assert_in_delta score, item.recommendation_score, 0.000000001 
      assert_equal name,  item.name 
    end
  end
  

end

