# require "rails_helper"

# feature "any user is able to see item show" do 
  
#   context "while not signed in" do
    
#     before(:each) do 
#       @store = Store.create(name: "Lunar Landing")
#       @category = Category.create(name: "space")
#       @item = @store.items.create(name: "moon rock", description: "rocky",
#                           expiration_date: "Time.now + 10.days",
#                           starting_price: 10,
#                           active: true, 
#                           category_id: @category.id )
#     end

#     it "can click bid and get routed to login or sign up" do
      
#     end
#   end
# end