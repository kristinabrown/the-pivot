require "rails_helper"

RSpec.describe "unregistered user cannot bid", type: :feature do 

  before(:each) do 
    store = Store.create!(name: "Collectibles Store")

    category = Category.create!(name: "Automobiles")

    item =  Item.create!(name: "moon car", description: "rocky",
                          expiration_date: "Time.now + 10.days",
                          starting_price: 10,
                          active: true, 
                          category_id: category.id, 
                          store_id: store.id )

    user = User.create!(fullname: "Sam Spade", 
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

  it "can see items to bid on" do 
    visit stores_path
    click_link "Collectibles Store"
    click_link "moon car"
    click_button "Bid Now"
    expect(current_path).to eq(login_path)
  end

  # it "can click on bid button and be routed to login" do

  # end




end


  # def create_user
 
    # user_logs_in
    # expect(current_path).to eq(users_path)
    # expect(page).to have_content("Welcome, #{user.display_name}!")
  # end

  # def user_logs_in
  #   visit login_path
  #   fill_in("session[email]",    with: "sam@sample.com" )
  #   fill_in("session[password]", with: "password" )  
  #   click_button "Login"
  # end
