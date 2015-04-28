require 'rails_helper'

RSpec.describe Beer, type: :model do
  let(:beer) { Beer.create(name: "Titan",
                           state: true,
                           description: "aggressively hopped ipa",
                           price: 350) }
  context "is valid" do
    it "is valid with valid attributes" do
      expect(beer).to be_valid
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

    it "responds to users" do
      expect(beer.users).to eq([])
    end

    it "responds to oders" do
      expect(beer.orders).to eq([])
    end

    it "responds to categories" do
      expect(beer.categories).to eq([])
    end
  end
end
