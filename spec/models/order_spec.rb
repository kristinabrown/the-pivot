require 'rails_helper'

RSpec.describe Order, type: :model do
  before(:each) do 
    store = Store.create!(name: "Collectibles Store")

    category = Category.create!(name: "Automobiles")

    @item =  Item.create!(name: "moon car", description: "rocky",
                          expiration_date: "Time.now + 10.days",
                          starting_price: 10,
                          active: true, 
                          category_id: category.id, 
                          store_id: store.id )
    @user = User.create!(fullname: "Jack Spade", 
                         email: "jack@sample.com",
                         display_name: "jackie",
                         role: 0,
                         phone: "222-333-4444",
                         password: "password",
                         street: "123 First Ave",
                         city: "Denver",
                         state: "CO",
                         zipcode: "80211",
                         credit_card: "4242424242424242",
                         cc_expiration_date: "2015-11-05"
                        )
  end
  
  let(:order){Order.create!(user_id: @user.id, total: 10, item_id: @item.id)}
  
  context "is valid" do
    it "is valid with valid attributes" do
      expect(order).to be_valid
    end
  end

  context "is invalid with invalid attributes" do
    it "is invalid without user_id" do
      order = Order.new(item_id: @item.id, total: 1000)

      expect(order).to_not be_valid
    end

    it "is invalid without item id" do
      order = Order.new(user_id: @user.id, total: 1000)

      expect(order).to_not be_valid
    end

    it "is invalid without total" do
      order = Order.new(item_id: @item.id, user_id: @user.id)

      expect(order).to_not be_valid
    end

    it "responds to user" do
      expect(order.user.id).to eq(@user.id)
    end
    
    it "can find it's order" do 
      expect(order.item.name).to eq("moon car")
    end
    
    it "can create orders" do
      Bid.create!(current_price: 15, user_id: @user.id, item_id: @item.id)
      @item.update(expiration_date: Time.now - 1.day)
      Order.create_order
      
      expect(Order.first.user_id).to eq(@user.id)
    end
  end
end
  