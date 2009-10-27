require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProductsController do

  describe "GET 'rate'" do
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
    end        
    
    it "search products" do                                                                              
      params = Hash.new                       
      products = [Factory.create :product]
      search = mock 'Search', :all => products 
      search.should_receive(:all).and_return(products)
      Product.should_receive(:search).and_return(search)
      get 'index', params                
      assigns[:products].should be(products)
    end
  end
  
end
