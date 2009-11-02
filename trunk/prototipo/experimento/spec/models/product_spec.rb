require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Product do

  it "should create a new instance given valid attributes" do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :path => "value for path",
      :photo => "value for photo",
      :img_alt => "value for img_alt",
      :brand => "value for brand",
      :category_id => 1,
      :selected => false
    }
    Product.create!(@valid_attributes)
  end

end
