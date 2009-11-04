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
          @controller.should_receive(:current_user).and_return(current_user)
        end

        it "search products" do                                                                              
          params = Hash.new                       
          products = [Factory.create :product]
          search = mock 'Search', :all => products 
          search.should_receive(:all).and_return(products)
          Product.should_receive(:search).and_return(search)
          get 'index', params                
          assigns[:products].should include(products.first)
        end  
      end
    end
  end

end
