require "rails_helper"

feature "a user is able to edit" do 
  let(:user) {User.create({fullname: "Wolfgang Mozart", username: "Wolfie", email: "MCProdigy@gmail.com", password: "password", password_confirmation: "password", phone_number: "303-675-1234", role: 0})}

  scenario "his/her profile" do 
    visit user_path
    click_link "Edit Profile"
    expect(page).to have_content("Wolfgang Mozart")
    expect(page).to have_content("MCProdigy@gmail.com")
    fill_in "user[fullname]", with: "Wolfgang Amadeus Mozart"
    fill_in "user[email]", with: "Wigmaster@hotmail.com"
    fill_in "user[password]", with: "12345"
    fill_in "user[password_confirmation]", with: "12345"
    click_button "Update"
    expect(page).to_not have_content("Wolfgang Mozart")
    expect(page).to have_content("Wolfgang Amadeus Mozart")
    expect(page).to_not have_content("MCProdigy@gmail.com")
    expect(page).to have_content("Wigmaster@hotmail.com")
  end 
end
