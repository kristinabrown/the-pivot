require "rails_helper"

describe Cart do

  describe "#add_item" do
    let(:store) {Store.create(name: "lunar landing")}
    let(:category) {Category.create(name: "space")}
    let(:item) {store.items.create(name: "moon rock", description: "rocky",
                        expiration_date: "Time.now + 10.days",
                        starting_price: 10,
                        active: true, 
                        category_id: category.id )}
    let(:item2) {store.items.create(name: "star dust", description: "rocky",
                        expiration_date: "Time.now + 10.days",
                        starting_price: 10,
                        active: true, 
                        category_id: category.id )}
    
    it "successfully adds a item to watch cart" do 
      cart = Cart.new({})
      cart.add_item(item)
      expect(cart.contents).to eq({item.id => item.id})
    end

    it "successfully adds two items" do 
      cart = Cart.new({})
      cart.add_item(item)
      cart.add_item(item2)
      expect(cart.contents).to eq({item.id => item.id, item2.id => item2.id})
    end

    it "successfully adds two and then deletes one" do 
      cart = Cart.new({})
      cart.add_item(item)
      cart.add_item(item2)
      expect(cart.contents).to eq({item.id => item.id, item2.id => item2.id})
      
      cart.delete_item(item2.id)
      expect(cart.contents).to eq({item.id => item.id})
    end
  end
end
