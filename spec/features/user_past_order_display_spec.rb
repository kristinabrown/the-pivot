require "rails_helper"

feature "an authenticated user's past orders" do 
  before(:each) do 
    beer1 = {name: "Yeti", state: true, description: "big, roasty malt flavor with rich caramel and toffee notes", price: 606, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:54:09 UTC")}
    beer2 = {name: "Chocolate Stout", state: true, description: "full-bodied flavor with hints of rich oatmeal and dark chocolate", price: 612, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:54:09 UTC")}
    user = User.create({fullname: "Wolfgang Mozart", display_name: "Wolfie", email: "MCProdigy@gmail.com", password: "password", password_confirmation: "password", phone: "303-675-1234", role: 0})
    @order = Order.create(user_id: user.id, status: "completed", total: 1218, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:58:15 UTC") )
    beer_orders = @order.beers.create(beer1)
    beer_orders2 = @order.beers.create(beer2)
    visit root_path
    click_link "Login"
    fill_in "session[email]", with: "MCProdigy@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Login"
  end

  scenario "will be displayed" do 
    click_link "Past Orders"
    click_link @order.id
    expect(page).to have_content("Yeti")
    expect(page).to have_content("Chocolate Stout")
    expect(@order.beers.count).to eq(2)
    expect(@order.status).to eq("completed")
    # expect(page).to have_css(".order")
    # expect(page).to have_css(".beer")
    expect(page).to have_content("$12.00")
    expect(page).to have_content(Date.parse("2012-03-25 09:54:09 UTC"))
    expect(page).to have_content(Date.parse("2012-03-25 09:54:09 UTC"))
  end
end

feature "a user's past orders" do 
  before(:each) do 
    beer1 = {name: "Yeti", state: true, description: "big, roasty malt flavor with rich caramel and toffee notes", price: 606, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:54:09 UTC")}
    beer2 = {name: "Chocolate Stout", state: false, description: "full-bodied flavor with hints of rich oatmeal and dark chocolate", price: 612, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:54:09 UTC")}
    user = User.create({fullname: "Wolfgang Mozart", display_name: "Wolfie", email: "MCProdigy@gmail.com", password: "password", password_confirmation: "password", phone: "303-675-1234", role: 0})
    @order = Order.create(user_id: user.id, status: "completed", total: 1218, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:58:15 UTC") )
    beer_orders = @order.beers.create(beer1)
    beer_orders2 = @order.beers.create(beer2)
    visit root_path
    click_link "Login"
    fill_in "session[email]", with: "MCProdigy@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Login"
  end

  scenario "will display an order that has an item that is retired" do 
    click_link "Past Orders"
    click_link @order.id
    expect(page).to have_content("Yeti")
    expect(page).to have_content("Chocolate Stout")
    expect(@order.beers.count).to eq(2)
    click_link "Chocolate Stout"
    expect(page).to have_content("full-bodied flavor with hints of rich oatmeal and dark chocolate")
    click_button "Add"
    expect(page).to have_content("The 'Chocolate Stout' is unavailable.")
  end
end

feature "a user's past orders" do 

  before(:each) do 
    @user1 = User.create({fullname: "Wolfgang Mozart", display_name: "Wolfie", email: "MCProdigy@gmail.com", password: "password", password_confirmation: "password", phone: "303-675-1234", role: 0})
    user2 = User.create({fullname: "Hans Zimmerman", display_name: "H-Bomb", email: "ZimmerShimmer@gmail.com", password: "password", password_confirmation: "password", phone: "303-123-1234", role: 0})
    @user1.orders.create(user_id: @user1.id, status: "paid", total: 1532, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:58:15 UTC"))
    user2.orders.create(user_id: user2.id, status: "cancelled", total: 2018, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:58:15 UTC"))
    visit root_path
    click_link "Login"
    fill_in "session[email]", with: "MCProdigy@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Login"
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
  end

  scenario "will display only that user's orders" do
    visit order_path(@user1.orders.first)
    expect(page).to have_content("paid")
    expect(page).to have_content("$15.00")
    expect(page).to_not have_content("cancelled")
  end

  scenario "will not allow access to admin functions" do 
    visit admin_orders_path
    expect(page).to_not have_content("Inventory")
    expect(page).to_not have_content("New Category")
    expect(page).to_not have_content("Current Categories")
  end
end

