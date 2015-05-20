# require "rails_helper"
# 
# feature "a user is able to edit" do 
#   let!(:user) {User.create({fullname: "Wolfgang Mozart", display_name: "Wolfie", email: "MCProdigy@gmail.com", password: "password", password_confirmation: "password", phone: "303-675-1234", role: 0})}
# 
#   before(:each) do 
#     visit root_path
#     click_link "Login"
#     fill_in "session[email]", with: "MCProdigy@gmail.com"
#     fill_in "session[password]", with: "password"
#     click_button "Login"
#   end
# 
#   scenario "his/her profile" do 
#     visit users_path(user)
#     click_link "Edit Profile"
#     expect(page).to have_content("Edit Profile")
# 
#     fill_in "user[display_name]", with: "Wolfdogg"
#     fill_in "user[email]", with: "Wigmaster@hotmail.com"
#     fill_in "user[password]", with: "12345"
#     fill_in "user[password_confirmation]", with: "12345"
#     click_button "Submit"
#     expect(page).to_not have_content("Wolfie")
#     expect(page).to have_content("Wolfdogg")
#   end 
# 
# end
