require "rails_helper"

feature "user logs in" do
    let!(:user) {User.create({fullname: "Wolfgang Mozart", display_name: "Wolfie", email: "MCProdigy@gmail.com", password: "password", password_confirmation: "password", phone: "303-675-1234", role: 0})}
  scenario "with valid credentials" do 
    visit root_path
    click_link "Login"
    fill_in "session[email]", with: "MCProdigy@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Login"
    expect(page).to have_content("Current Shopping Cart")
    expect(page).to have_content("Quantity")
    expect(page).to have_content("Price Per Item")
    expect(page).to have_content("Delete")
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
end


feature "user logs out" do 
  let!(:user) {User.create({fullname: "John Smith", display_name: "JD2000", email: "JD@gmail.com", password: "123", password_confirmation: "123", phone: "303-321-6543", role: 0})}
  scenario "after being logged in" do 
    visit root_path
    click_link "Login"
    fill_in "session[email]", with: "JD@gmail.com"
    fill_in "session[password]", with: "123"
    click_button "Login"
    expect(page).to have_content("Welcome, JD2000!")

    click_link "Logout"
    expect(page).to have_content("Our Story")
  end
end