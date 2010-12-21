require 'spec_helper'

describe "Product test" do
  fixtures :taxonomies, :taxons, :products, :model_alias, :variants, :properties, :product_properties, :assets
  it "find by brand and model" do
    a1 = MobileHelper.find_mobile('三星','W589')
    a2 = MobileHelper.find_mobile('三星','589')
    a1.should_not be_nil
    a2.should_not be nil
    a1.id.should == a2.id
  end

  it "merge products" do
    p1 = MobileHelper.find_mobile('三星', 'W589')
    p2 = MobileHelper.find_mobile('三星', 'W589C')
    p1.should_not be_nil
    p2.should_not be_nil
    p1.id.should_not == p2.id

    MobileHelper.merge([p1.id, p2.id])
    pp1 = MobileHelper.find_mobile('三星', 'W589')
    pp2 = MobileHelper.find_mobile('三星', 'W589C')
    pp1.should_not be_nil
    pp2.should_not be_nil
    pp1.id.should == pp2.id

    pp1.id.should == p1.id
    pp1.description.should == p2.description
    pp1.property('prop1').should == p2.property('prop1')
    pp1.property('prop2').should == p2.property('prop2')
    pp1.property('prop3').should == p1.property('prop3')

    Asset.where('viewable_type="Product" and viewable_id=?', pp1.id).count.should == 2
  end


end

describe "taxon test" do
  fixtures :taxonomies
  it "find in taxonomy" do
    Taxonomy.find_by_name('品牌').should_not be_nil
    Taxonomy.find_by_name('没有此分类').should be_nil
  end
end
