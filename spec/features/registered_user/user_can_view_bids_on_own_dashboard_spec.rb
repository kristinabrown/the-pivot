require "rails_helper"

RSpec.describe "unregistered user cannot bid", type: :feature do 

  before(:each) do 
    store = Store.create!(name: "Collectibles Store")

    category = Category.create!(name: "Automobiles")

    @item =  Item.create!(name: "moon car", description: "rocky",
                          expiration_date: Time.now + 10.days,
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
   end

   let(:user) do User.create!(fullname: "Sam Spade", 
     email: "sam@sample.com",
     display_name: "Sammie",
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
   end

  it "can click on bid button and be routed to user dashboard" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit stores_path
    click_link "Collectibles Store"
    click_link "moon car"
    click_button "Bid Now"
    expect(current_path).to eq(users_path)
    expect(page).to have_content("moon car")
    expect(page).to have_content("Time Remaining")
  end
  
  it "can see when they are out bid" do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit stores_path
    click_link "Collectibles Store"
    click_link "moon car"
    click_button "Bid Now"
    expect(current_path).to eq(users_path)
    
    Bid.create(item_id: @item.id, user_id: @user.id, current_price: @item.highest_bid + 1)
    
    visit users_path
    
    expect(page).to have_button("Bid")
  end
  
  it "can re-bid when out bid" do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit stores_path
    click_link "Collectibles Store"
    click_link "moon car"
    click_button "Bid Now"
    expect(current_path).to eq(users_path)
    
    Bid.create(item_id: @item.id, user_id: @user.id, current_price: @item.highest_bid + 1)
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit users_path
    expect(page).to have_button("Bid")
    
    fill_in "bid[current_price]", with: 100
    click_button("Bid")
    expect(page).to have_content("moon car")
  end
  
  
  it "can not rebid when highest bidder" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit stores_path
    click_link "Collectibles Store"
    click_link "moon car"
    click_button "Bid Now"
    expect(current_path).to eq(users_path)
    
    visit stores_path
    click_link "Collectibles Store"
    expect(page).to have_content("View your bid standing.")
  end
  
  it "can not bid less than starting amount" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit stores_path
    click_link "Collectibles Store"
    click_link "moon car"
    fill_in "bid[current_price]", with: 1
    click_button "Bid Now"
    expect(current_path).to eq(users_path)
    expect(page).to have_content("Invalid bid!")
  end
  
  it "can not bid less than current bid" do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit stores_path
    click_link "Collectibles Store"
    click_link "moon car"
    click_button "Bid Now"
    expect(current_path).to eq(users_path)
    
    Bid.create(item_id: @item.id, user_id: @user.id, current_price: @item.highest_bid + 1)
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit users_path
    
    fill_in "bid[current_price]", with: 1
    click_button("Bid")
    
    expect(page).to have_content("Invalid bid!")
  end
end
