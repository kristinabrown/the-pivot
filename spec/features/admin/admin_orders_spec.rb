require 'rails_helper'

RSpec.describe'admin orders' do
  context 'with admin logged in' do

    let(:admin) do
      User.create(fullname: "Kristinnie",
                  password: "pw",
                  email: "group@email.com",
                  phone: "111-111-1111",
                  role: 1)
    end

    before(:each) do 
      user = User.create({fullname: "Wolfgang Mozart", display_name: "Wolfie", email: "MCProdigy@gmail.com", password: "password", password_confirmation: "password", phone: "303-675-1234", role: 0})
      beer1 = {name: "Yeti", state: true, description: "big, roasty malt flavor with rich caramel and toffee notes", price: 606, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:54:09 UTC")}
      beer2 = {name: "Chocolate Stout", state: true, description: "full-bodied flavor with hints of rich oatmeal and dark chocolate", price: 612, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:54:09 UTC")}
      @order = Order.create(user_id: user.id, status: "ordered", total: 1218, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:58:15 UTC") )
      beer_orders = @order.beers.create(beer1)
      beer_orders2 = @order.beers.create(beer2)
    end

    xit 'displays the orders' do
      visit root_path
      click_link "Login"
      fill_in "session[email]", with: "group@email.com"
      fill_in "session[password]", with: "pw"
      click_button "Login"
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      click_link "All Orders"
      expect(page).to have_content("All Orders")
      expect(page).to have_content(@order.id)
    end

    xit "displays the contents of a single order" do
      visit admin_orders_path
      click_link @order.id
      expect(page).to have_content(Date.parse("2012-03-25 09:54:09 UTC"))
      #purchaser full name and email address
      expect(page).to have_content("")
      #name linked to item page
      #quantity
      #price  
      #line item subtotal
      expect(page).to have_content("Yeti")
      expect(page).to have_content("Chocolate Stout")
      expect(@order.beers.count).to eq(2)
      expect(@order.status).to eq("completed")
    end

    xit "edits an order" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_orders_path
      expect(page).to have_content("ordered")
      select "paid", from: "order[status]"
      click_button "Update Order"  
      expect(page).to have_content("paid")
    end

  end

  context 'with default user logged in' do
    let(:user) do
      User.create(fullname: "Bum",
                  password: "pw",
                  email: "homeless@email.com",
                  phone: "111-111-1111",
                  role: 0)
    end

    it "displays a 404 error" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit admin_orders_path
      expect(page).to have_content("404")
    end
  end

end