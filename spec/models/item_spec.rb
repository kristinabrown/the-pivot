require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:category){ Category.create(name: "space") }
  let(:store){Store.create(name: "lunar landing") }
  let(:item){ Item.create(name: "moon rock", description: "rocky",
                          expiration_date: "Time.now + 10.days",
                          starting_price: 10,
                          category_id: category.id, 
                          store_id: store.id )}

  context "is valid" do
    it "is valid with valid attributes" do
      expect(item).to be_valid
    end
  end
  
  context "is invalid" do
    it "is invalid without name" do
      item.update(name: nil)
      expect(item).to_not be_valid
    end
    
    it "is invalid without description" do
      item.update(description: nil)
      expect(item).to_not be_valid
    end
    
    it "is invalid without starting price" do
      item.update(starting_price: nil)
      expect(item).to_not be_valid
    end
    
    it "is invalid without expiration date" do
      item.update(expiration_date: nil)
      expect(item).to_not be_valid
    end
    
    it "is invalid without store id" do
      item.update(store_id: nil)
      expect(item).to_not be_valid
    end
    
    it "is invalid without category id" do
      item.update(category_id: nil)
      expect(item).to_not be_valid
    end
    
    it "can find it's store slug" do
      expect(item.store_slug).to eq("lunar-landing")
    end
  end
end