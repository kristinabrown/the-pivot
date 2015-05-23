require "rails_helper"

feature "any user is able to see item show" do 
  
  context "while not signed in" do
    
    before(:each) do 
      @store = Store.create(name: "Lunar Landing")
      @category = Category.create(name: "space")
      @item = @store.items.create(name: "moon rock", description: "rocky",
                          expiration_date: "Time.now + 10.days",
                          starting_price: 10,
                          active: true, 
                          category_id: @category.id )
      User.create!(fullname: "Wolfgang Mozart", display_name: "Wolfie", email: "MCProdigy@gmail.com", password: "password", phone: "303-675-1234",
       street: "this", city: "Denver", state: "CO", zipcode: "80206", credit_card: "1111111111111111", cc_expiration_date: Date.new)
    end

    it "can click bid and get routed to login or sign up" do
      visit root_path
      click_link "Shops"
      click_link "Lunar Landing"
      click_link "moon rock"
      click_button "Bid Now"
      
      expect(page).to have_content("Login or Sign Up to post your bid.")
      expect(current_path).to eq("/login")
    end
    
    it "can click bid, login and view posted bid" do
      visit root_path
      click_link "Shops"
      click_link "Lunar Landing"
      click_link "moon rock"
      click_button "Bid Now"
      
      fill_in "session[email]", with: "MCProdigy@gmail.com"
      fill_in "session[password]", with: "password"
      click_button "Login"
      
      expect(page).to have_content("Welcome, Wolfie!")
      expect(page).to have_content("moon rock")
      expect(page).to have_content("You're the highest bidder!")
      expect(current_path).to eq("/users")
    end
    
    it "can click bid, sign up, and view posted bid" do
      visit root_path
      click_link "Shops"
      click_link "Lunar Landing"
      click_link "moon rock"
      click_button "Bid Now"
      click_link "New User? Sign Up"
      
      fill_in "user[fullname]", with: "Wolfgang"
      fill_in "user[display_name]", with: "Wolfgang"
      fill_in "user[email]", with: "sample@sample.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      fill_in "user[street]", with: "main st"
      fill_in "user[city]", with: "denver"
      fill_in "user[state]", with: "CO"
      fill_in "user[zipcode]", with: "80206"
      fill_in "user[credit_card]", with: "1111111111111111"
      select 2016, from: "user[cc_expiration_date(1i)]"
      select "June", from: "user[cc_expiration_date(2i)]"
      click_button "Submit"
      
      expect(page).to have_content("Welcome, Wolfgang!")
      expect(page).to have_content("moon rock")
      expect(page).to have_content("You're the highest bidder!")
      expect(current_path).to eq("/users")
    end
  end
end