require 'rails_helper'

RSpec.describe Store, type: :model do
  let(:store) { Store.create(name: "lunar landing") }
  
  context "is valid" do
    it "is valid with valid attributes" do
      expect(store).to be_valid
    end
  end
  
  context "is invalid with invalid attributes" do
    it "is invalid without name" do
      store.update(name: "")
      expect(store).to_not be_valid
    end
    
    it "is invalid if it is not unique" do
      Store.create(name: "lunar landing")
      Store.create(name: "lunar landing")
      
      expect(Store.all.count).to eq(1)
    end
  end
end
