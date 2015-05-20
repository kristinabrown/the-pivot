require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:category){ Category.create(name: "space") }
  let(:store){Store.create(name: "lunar landing") }
  let(:item){ Item.create(name: "moon rock", description: "rocky",
                          expiration_date: "Time.now + 10.days",
                          starting_price: 10,
                          active: true, 
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
      expect(item).to be_valid
    end


end