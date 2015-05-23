require "rails_helper"

feature "a guest is able to sign up" do
  context "with valid attributes" do
    it "creates an account" do
      visit new_users_path
      fill_in "user[fullname]", with: "Wolfgang"
      fill_in "user[display_name]", with: "Wolfie"
      fill_in "user[email]", with: "MCProdigy@gmail.com"
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
      
      expect(page).to have_content("Welcome, Wolfie!")
      expect(current_path).to eq("/users")
    end
  end
  
  context "with invalid attributes" do
    it "gets a flash error" do
      visit new_users_path
      fill_in "user[fullname]", with: "Wolfgang"
      fill_in "user[display_name]", with: "Wolfie"
      fill_in "user[email]", with: "MCProdigy@gmail.com"
      fill_in "user[password]", with: "password"
      fill_in "user[street]", with: "main st"
      fill_in "user[city]", with: "denver"
      fill_in "user[state]", with: "CO"
      fill_in "user[zipcode]", with: "80206"
      fill_in "user[credit_card]", with: "1111111111111111"
      select 2016, from: "user[cc_expiration_date(1i)]"
      select "June", from: "user[cc_expiration_date(2i)]"
      click_button "Submit"
      
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end 