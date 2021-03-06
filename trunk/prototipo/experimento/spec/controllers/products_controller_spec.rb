require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProductsController do

  describe "GET 'rate'" do
    before(:each) do
      @controller.stub(:admin_signed_in?, false)
      @controller.stub(:user_signed_in?, true)  
      @controller.should_receive(:authenticate_user!).and_return(true) 

    end
    it "should be successful" do
      pending
      get 'rate'
      response.should be_success
    end
  end 

  describe "GET 'index'" do

    before(:each) do
      @controller.stub(:admin_signed_in?, false)
      @controller.stub(:user_signed_in?, true)  
      @controller.should_receive(:authenticate_user!).and_return(true)
    end                                                               

    (1..6).each do |stage_number|

      context "stage #{stage_number}" do
        before(:each) do
          current_user = mock_model User, :stage_number => stage_number
          @controller.should_receive(:current_user).at_least(1).and_return(current_user)
        end

        it "search products" do                                                                              
          params = {:search => {:name_like => 'a'}}                        
          products = []
          search = mock 'Search', :paginate => products
          products_with_user_ratings = mock Array, :search => search
          Product.should_receive(:with_ratings_from).and_return(products_with_user_ratings)
          get 'index', params                
          assigns[:products].should be(products)
        end  
      end   
      
    end
  end

end
