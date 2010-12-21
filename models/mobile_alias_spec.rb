require 'spec_helper'

describe "Mobile Alias test" do
  fixtures :taxonomies, :taxons, :products, :model_alias, :variants, :properties, :product_properties, :assets
  
  it "> model alias" do
    p = Product.first
    ModelAlia.product_alias(p.id).should == 'W589,589'
  end

  it "> add alias" do
    p = Product.first
    ModelAlia.add_alias(p.id, 'www')
    p1 = MobileHelper.find_mobile('三星', 'WWW')
    p1.id.should == p.id

    ModelAlia.add_alias(p.id, 'WWW')
    p1 = MobileHelper.find_mobile('三星', 'WWW')
    p1.id.should == p.id
  end

  it "> change alias" do
    p = Product.first
    ModelAlia.set_alias(p.id, 'W589,www')
    p1 = MobileHelper.find_mobile('三星', 'WWW')
    p1.id.should == p.id

    p1 = MobileHelper.find_mobile('三星', '589')
    p1.should be_nil
  end
end

