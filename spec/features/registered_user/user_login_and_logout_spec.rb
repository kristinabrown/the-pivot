require "rails_helper"

feature "user logs in" do
    let!(:user) {User.create!(fullname: "Wolfgang Mozart", display_name: "Wolfie", email: "MCProdigy@gmail.com", password: "password", phone: "303-675-1234",
     street: "this", city: "Denver", state: "CO", zipcode: "80206", credit_card: "1111111111111111", cc_expiration_date: Date.new)}
  
  scenario "with valid credentials" do 
    visit root_path
    click_link "Login"
    fill_in "session[email]", with: "MCProdigy@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Login"
    expect(page).to have_content("Welcome, Wolfie!")
  end

  scenario "with invalid credentials - mispelled email" do 
    visit root_path
    click_link "Login"
    fill_in "session[email]", with: "MProdigy@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Login"
    expect(page).to have_content("Invalid login")
  end

  scenario "with invalid credentials - wrong password" do 
    visit root_path
    click_link "Login"
    fill_in "session[email]", with: "MCProdigy@gmail.com"
    fill_in "session[password]", with: "boguspassword"
    click_button "Login"
    expect(page).to have_content("Invalid login")
  end

  scenario "user logs out" do 
    visit root_path
    click_link "Login"
    fill_in "session[email]", with: "MCProdigy@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Login"
    expect(page).to have_content("Welcome, Wolfie!")

    click_link "Logout"
    expect(page).to have_content("Successfully logged out")
  end
end