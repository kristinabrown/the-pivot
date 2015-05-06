require 'rails_helper'

RSpec.describe "unauthenicated user" do 
  context "when not signed in" do
    let(:user) { User.create(fullname: "milli", email: "sample@sample.com", password: "pw")}
    let(:order) { Order.create(user_id: user.id, total: 400, status: "ordered") }
    it "cannot view any orders page" do
      visit orders_path
      
      expect(page).to have_content("Must be logged in to view orders")
    end
    
    it "cannot view an individual order page" do
      visit order_path(order)
      
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
      
      