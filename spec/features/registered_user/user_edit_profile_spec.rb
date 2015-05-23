require "rails_helper"

feature "a user is able to edit" do 
  before(:each) { @user = User.create({fullname: "Wolfgang Mozart", display_name: "Wolfie", email: "MCProdigy@gmail.com", password: "password", phone: "303-675-1234",
    street: "this", city: "Denver", state: "CO", zipcode: "80206", credit_card: "1111111111111111", cc_expiration_date: "11/16"})}

  xscenario "his/her profile" do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    
    visit edit_users_path 

    fill_in "Display name", with: "Wolfdogg"

    click_button "Submit"
    save_and_open_page
    expect(page).to_not have_content("Welcome, Wolfie!")
    expect(page).to have_content("Welcome, Wolfdogg!")
  end 
end
