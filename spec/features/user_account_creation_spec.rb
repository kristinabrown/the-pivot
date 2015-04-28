require "rails_helper"

feature "user creates account" do 
  scenario "successfully" do 
    visit root_path
    click_link "Register"
    fill_in "user[fullname]", with: "George Orwell"
    fill_in "user[email]", with: "GeorgeO@gmail.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    fill_in "user[phone]", with: "303-333-3333"
    click_button "Submit"

    expect(page).to have_content("Welcome, George Orwell!")
  end

  scenario "unsuccessfully - fullname is blank" do 
    visit root_path
    click_link "Register"
    fill_in "user[fullname]", with: ""
    fill_in "user[email]", with: "GeorgeO@gmail.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    fill_in "user[phone]", with: "303-333-3333"
    click_button "Submit"
    expect(page).to have_content("Fullname can't be blank")
  end

  scenario "with unmatching passwords" do 
    visit root_path
    click_link "Register"
    fill_in "user[fullname]", with: ""
    fill_in "user[email]", with: "GeorgeO@gmail.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "passwor"
    fill_in "user[phone]", with: "303-333-3333"
    click_button "Submit"
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario "with the same email address" do 
    visit root_path
    click_link "Register"
    fill_in "user[fullname]", with: "George Orwell"
    fill_in "user[email]", with: "GeorgeO@gmail.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    fill_in "user[phone]", with: "303-333-3333"
    click_button "Submit"

    visit root_path
    click_link "Register"
    fill_in "user[fullname]", with: "George Orwell"
    fill_in "user[email]", with: "GeorgeO@gmail.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    fill_in "user[phone]", with: "303-333-3333"
    click_button "Submit"
    expect(page).to have_content("Email has already been taken")
  end

  xscenario "uploads an image" do
    visit root_path
    click_link "Register"
    fill_in "user[fullname]", with: "George Orwell"
    fill_in "user[email]", with: "GeorgeO@gmail.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    fill_in "user[phone]", with: "303-333-3333" 
    page.attach_file('user[attachment]', Rails.root + 'spec/images/george.jpg')
    expect(page).to have_css(".profile_picture")
  end

  scenario "and opts for a display name" do 
    visit root_path
    click_link "Register"
    fill_in "user[fullname]", with: "George Orwell"
    fill_in "user[display_name]", with: "G-Money"
    fill_in "user[email]", with: "GeorgeO@gmail.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    fill_in "user[phone]", with: "303-333-3333"
    click_button "Submit"
    expect(page).to have_content("Welcome, G-Money!")
  end

  scenario "and doesn't fill in the display name" do 
    visit root_path
    click_link "Register"
    fill_in "user[fullname]", with: "George Orwell"
    fill_in "user[display_name]", with: ""
    fill_in "user[email]", with: "GeorgeO@gmail.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    fill_in "user[phone]", with: "303-333-3333"
    click_button "Submit"
    expect(page).to have_content("Welcome, George Orwell!")
  end

  scenario "with invalid username - too short" do 
    visit root_path
    click_link "Register"
    fill_in "user[fullname]", with: "George Orwell"
    fill_in "user[display_name]", with: "G"
    fill_in "user[email]", with: "GeorgeO@gmail.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    fill_in "user[phone]", with: "303-333-3333"
    click_button "Submit"
    expect(page).to have_content("Display name is too short")
  end

  scenario "with invalid username - too long" do 
    visit root_path
    click_link "Register"
    fill_in "user[fullname]", with: "George Orwell"
    fill_in "user[display_name]", with: "GeorgeOrwellistheshiznitbombdiggity"
    fill_in "user[email]", with: "GeorgeO@gmail.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    fill_in "user[phone]", with: "303-333-3333"
    click_button "Submit"
    expect(page).to have_content("Display name is too long")
  end
end