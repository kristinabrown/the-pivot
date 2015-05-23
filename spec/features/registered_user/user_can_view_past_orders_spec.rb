require "rails_helper"

RSpec.describe "unregistered user cannot bid", type: :feature do 

  before(:each) do 
    store = Store.create!(name: "Collectibles Store")

    category = Category.create!(name: "Automobiles")

    @item =  Item.create!(name: "moon car", description: "rocky",
                          expiration_date: "Time.now + 10.days",
                          starting_price: 10,
                          active: true, 
                          category_id: category.id, 
                          store_id: store.id )
    @user = User.create!(fullname: "Jack Spade", 
                         email: "jack@sample.com",
                         display_name: "jackie",
                         role: 0,
                         phone: "222-333-4444",
                         password: "password",
                         street: "123 First Ave",
                         city: "Denver",
                         state: "CO",
                         zipcode: "80211",
                         credit_card: "4242424242424242",
                         cc_expiration_date: "2015-11-05"
                        ) 
    @order = Order.create!(user_id: @user.id, item_id: @item.id, total: 10)
   end
   
   it "can see all past orders on their dashboard" do
     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
     visit users_path
     click_link "Past Orders"
     
     expect(page).to have_content("moon car")
     expect(page).to have_content("Past Orders")
   end

 end
