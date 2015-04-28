require 'rails_helper'

RSpec.describe Order, type: :model do
  before(:all) { User.create(fullname: "David Daniel", 
                             email: "example@example.org",
                             role: 0,
                             phone: "222-333-4444",
                             password: "password") }
                           
  let(:order) { Order.create(user_id: User.first.id, 
                             status: "ordered",
                              total: 1000) }
  context "is valid" do
    it "is valid with valid attributes" do
      expect(order).to be_valid
    end
  end

  context "is invalid with invalid attributes" do
    it "is invalid without user_id" do
      order = Order.new(status: "completed", total: 1000)

      expect(order).to_not be_valid
    end

    it "is invalid without status" do
      order = Order.new(user_id: 1, total: 1000)

      expect(order).to_not be_valid
    end

    it "is invalid without total" do
      order = Order.new(status: "completed", user_id: 1)

      expect(order).to_not be_valid
    end

    it "responds to user" do
      expect(order.user.id).to eq(User.first.id)
    end

    it "responds to beers" do
      expect(order.beers).to eq([])
    end
  end
end
  