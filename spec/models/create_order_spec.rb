# require 'rails_helper'
# 
# describe 'Creating orders' do
# 
#   context 'with valid attributes' do
#     
#     let(:valid_attributes) { { "order_info"=> {"beers"=> {"#{@beer.id}"=>{"beer_price"=>"2000", "quantity"=>"5"}}, "total"=>"20", "user_id"=>"2"}
#     } }
#     
#     it "parses the values" do
#       @beer = Beer.create(id: 3, name: "this beer", description: "yummy", price: 500)
#       create_order = CreateOrder.new(valid_attributes)
#       
#       expect(create_order.user_id).to eq("2")
#       expect(create_order.total).to eq("20")
#     end
#   end
# end