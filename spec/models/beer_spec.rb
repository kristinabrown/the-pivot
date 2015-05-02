require 'rails_helper'

RSpec.describe Beer, type: :model do
  let(:beer) { Beer.create(name: "Titan",
                           state: true,
                           description: "aggressively hopped ipa",
                           price: 350) }

  let(:beer2) { Beer.create(name: "Titan2",
                           state: false,
                           description: "aggressively hopped ipa",
                           price: 350) }
  context "is valid" do
    it "is valid with valid attributes" do
      expect(beer).to be_valid
    end

    it "is valid with false state " do
      expect(beer2).to be_valid
    end
  end

  context "is invalid with invalid attributes" do
    it "is invalid without name" do
      beer = Beer.new(state: true,
                      description: "aggressively hopped ipa",
                      price: 350)

      expect(beer).to_not be_valid
    end

    it "is invalid without state" do
      beer = Beer.new(name: "titan",
                      description: "aggressively hopped ipa",
                      price: 350)

      expect(beer).to_not be_valid
    end

    it "is invalid without description" do
      beer = Beer.new(name: "titan",
                      state: true,
                      price: 350)

      expect(beer).to_not be_valid
    end

    it "is invalid without price" do
      beer = Beer.new(name: "titan",
                      state: true,
                      description: "aggressively hopped ipa")

      expect(beer).to_not be_valid
    end
    
    it "is invalid with empty string name" do
      beer = Beer.new(name: "",
                      state: true,
                      description: "aggressively hopped ipa",
                      price: 350) 
      expect(beer).to_not be_valid
    end
    
    it "is invalid with empty string description" do
      beer = Beer.new(name: "Titam",
                      state: true,
                      description: "",
                      price: 350) 
      expect(beer).to_not be_valid
    end
    
    it "responds to oders" do
      expect(beer.orders).to eq([])
    end

    it "responds to categories" do
      expect(beer.categories).to eq([])
    end
  end
end
