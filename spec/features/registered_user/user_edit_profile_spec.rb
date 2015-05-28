require "rails_helper"

feature "a user is able to edit" do 

  scenario "his/her profile" do 
   User.create!(fullname: "Wolfgang Mozart", display_name: "Wolfie", email: "MCProdigy@gmail.com", password: "password", phone: "303-675-1234",
    street: "this", city: "Denver", state: "CO", zipcode: "80206", credit_card: "1111111111111111", cc_expiration_date: Date.new)
    visit login_path
    fill_in "session[email]", with: "MCProdigy@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Login"
    
    visit users_path
    click_link "Edit Profile"
    

    fill_in "Display name", with: "Wolfdogg"
    fill_in "user[password]", with: "password"
    fill_in "Password confirmation", with: "password"
    
    click_button "Submit"

    expect(page).to_not have_content("Welcome, Wolfie!")
    expect(page).to have_content("Welcome, Wolfdogg!")
  end 
end
