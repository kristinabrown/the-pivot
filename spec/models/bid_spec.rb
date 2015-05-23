require 'rails_helper'

RSpec.describe Bid, type: :model do
  
  context "with valid attributes" do
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
    
    let(:bid) { Bid.create(user_id: @user.id, item_id: @item.id, current_price: 3000) }
    
    it "is valid" do
      expect(bid).to be_valid
    end
    
    it "is invalid with invalid without current price" do
      bid.update(current_price: nil)
      expect(bid).to_not be_valid
    end
    
    it "is invalid without user id" do
      bid.update(user_id: nil)
      expect(bid).to_not be_valid
    end
    
    it "is invalid without item id" do
      bid.update(current_price: nil)
      expect(bid).to_not be_valid
    end
    
    it "can find it's item" do
      item = bid.item
      expect(item.name).to eq("moon car")
    end
    
    it "can know if it exsits" do
      Bid.bid_exsits?(@user.id, @item.id)
    end
  end
end
