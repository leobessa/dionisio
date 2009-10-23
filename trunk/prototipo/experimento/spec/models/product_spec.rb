require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Product do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :path => "value for path",
      :img_src => "value for img_src",
      :img_alt => "value for img_alt",
      :brand => "value for brand",
      :category_id => 1,
      :selected => false
    }
  end

  it "should create a new instance given valid attributes" do
    Product.create!(@valid_attributes)
  end
end
