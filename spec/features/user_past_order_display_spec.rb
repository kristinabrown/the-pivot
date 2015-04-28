require "rails_helper"

feature "a user's past orders" do 
  before(:each) do 
  category = Category.create(name: "Stout", description: "warm, rich, chocolate undertones")
  beer1 = Beer.create(name: "Yeti", state: true, category_id: category.id, description: "big, roasty malt flavor with rich caramel and toffee notes", price: 606, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:54:09 UTC"))
  beer2 = Beer.create(name: "Chocolate Stout", state: true, category_id: category.id, description: "full-bodied flavor with hints of rich oatmeal and dark chocolate", price: 612, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:54:09 UTC"))
  user = User.create({fullname: "Wolfgang Mozart", username: "Wolfie", email: "MCProdigy@gmail.com", password: "password", password_confirmation: "password", phone_number: "303-675-1234", role: 0})
  order = Order.create(user_id: user.id, status: "completed", total: 1218, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:58:15 UTC") )
  visit root_path
  click_link "Login"
  fill_in "user[email]", with: "MCProdigy@gmail.com"
  fill_in "user[password]", with: "password"
  click_button "Login"
  end

  xscenario "will be displayed" do 
    click_link "Past Orders"
    click_link "Order 1"
    expect(page).to have_content("Yeti")
    expect(page).to have_content("Chocolate Stout")
    expect(beer1.count).to eq(1)
    expect(beer2.count).to eq(1)
    expect(order.status).to eq("completed")
    expect(page).to have_css(".order")
    expect(page).to have_css(".beer")
    expect(page).to have_content(12.18)
    expect(page).to have_content("03-25-2012")
    expect(page).to have_content(Date.parse("2012-03-25 09:54:09 UTC"))
    expect(page).to have_content(Date.parse("2012-03-25 09:54:09 UTC"))
  end
end

feature "a user's past orders" do 
  before(:each) do 
  category = Category.create(name: "Stout", description: "warm, rich, chocolate undertones")
  beer1 = Beer.create(name: "Yeti", state: true, category_id: category.id, description: "big, roasty malt flavor with rich caramel and toffee notes", price: 606, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:54:09 UTC"))
  beer2 = Beer.create(name: "Chocolate Stout", state: false, category_id: category.id, description: "full-bodied flavor with hints of rich oatmeal and dark chocolate", price: 612, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:54:09 UTC"))
  user = User.create({fullname: "Wolfgang Mozart", username: "Wolfie", email: "MCProdigy@gmail.com", password: "password", password_confirmation: "password", phone_number: "303-675-1234", role: 0})
  order = Order.create(user_id: user.id, status: "completed", total: 1218, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:58:15 UTC"))
  visit root_path
  click_link "Login"
  fill_in "user[email]", with: "MCProdigy@gmail.com"
  fill_in "user[password]", with: "password"
  click_button "Login"
  end

  xscenario "will display an order that has an item that is retired" do 
    click_link "Past Orders"
    click_link "Order 1"
    expect(page).to have_content("Yeti")
    expect(page).to have_content("Chocolate Stout")
    expect(beer1.count).to eq(1)
    expect(beer2.count).to eq(1)
    click_link "Chocolate Stout"
    expect(page).to have_content("full-bodied flavor with hints of rich oatmeal and dark chocolate")
    expect(page).to_not have_content("Add")
  end
end

feature "a user's past orders" do 

  before(:each) do 
  user1 = User.create({fullname: "Wolfgang Mozart", username: "Wolfie", email: "MCProdigy@gmail.com", password: "password", password_confirmation: "password", phone_number: "303-675-1234", role: 0})
  user2 = User.create({fullname: "Hans Zimmerman", username: "H-Bomb", email: "ZimmerShimmer@gmail.com", password: "password", password_confirmation: "password", phone_number: "303-123-1234", role: 0})
  user1.orders.create(user_id: user1.id, status: "paid", total: 1532, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:58:15 UTC"))
  user2.orders.create(user_id: user2.id, status: "cancelled", total: 2018, created_at: Date.parse("2012-03-25 09:54:09 UTC"), updated_at: Date.parse("2012-03-25 09:58:15 UTC"))
  visit root_path
  click_link "Login"
  fill_in "user[email]", with: "MCProdigy@gmail.com"
  fill_in "user[password]", with: "password"
  click_button "Login"
  end

  xscenario "will display only that user's orders" do 
    expect(page).to have_content("paid")
    expect(page).to have_content("1532")
    expect(page).to_not have_content("cancelled")
  end
end