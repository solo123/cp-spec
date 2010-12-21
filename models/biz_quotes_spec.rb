require 'spec_helper'

describe "Biz Quotes test" do
  fixtures :taxonomies, :taxons, :products, :model_alias, :variants, :properties, :product_properties

  it "> import quotes" do
    text_block = "W589\t150/160/170\t什么机器\nW666\t200\t没有机器"
    biz = BizQuotes.new(1)
    biz.import_text_block_to_quotes('三星', '主推机型,优势机型', text_block)

    biz.error_message.should == ''
    qs = Quote.all(:limit => 2)
    q = qs[0]
    q.brand.should == '三星'
    q.model.should == 'W589'
    q.price.should == 150
    q.remark.should == '150/160/170什么机器'

    q1 = qs[1]
    q1.brand.should == '三星'
    q1.model.should == 'W666'
    q1.price.should == 200
    q1.remark.should == '没有机器'
  end

end
