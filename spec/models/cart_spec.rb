# require "rails_helper"
# 
# describe Cart do
# 
#   describe "#add_beer" do
#     let(:beer) {Beer.create(name: "Yeti", state: true, description: "big, roasty malt flavor with rich caramel and toffee notes", price: 606)}
#     let(:beer2) {Beer.create(name: "Titan", state: true, description: "big, roasty malt flavor with rich caramel and toffee notes", price: 606)}
#     
#     it "successfully adds a beer and quantity to the cart" do 
#       cart = Cart.new({})
#       cart.add_beer(beer, 1)
#       expect(cart.contents).to eq({beer.id.to_s=>{"quantity"=>1}})
#     end
# 
#     it "successfully adds two beer and the quantity to the cart" do 
#       cart = Cart.new({})
#       cart.add_beer(beer, 1)
#       cart.add_beer(beer2, 1)
#       expect(cart.contents).to eq({beer.id.to_s=>{"quantity"=>1}, beer2.id.to_s=>{"quantity"=>1}})
#     end
# 
#     it "successfully adds the same beer twice to the cart" do 
#       cart = Cart.new({})
#       cart.add_beer(beer, 1)
#       cart.add_beer(beer, 2)
#       expect(cart.contents).to eq({beer.id.to_s=>{"quantity"=>3}})
#     end
#   end
# end
