require "rails_helper"

feature "an admin logs in" do
  let!(:admin) {User.create({fullname: "Fred Durst", display_name: "Dbag55", email: "Buckethat@gmail.com", password: "password", password_confirmation: "password", phone: "303-345-1234", role: 1})}

  scenario "successfully and is redirected to the beers index" do
    visit root_path
    click_link "Login"
    fill_in "session[email]", with: "Buckethat@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Login"
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    expect(current_path).to eq(admin_dashboard_path)
  end

  scenario "unsuccessfully and is redirected back to the login path" do
    visit root_path
    click_link "Login"
    fill_in "session[email]", with: "Buckhat@gmail.com"
    fill_in "session[password]", with: "password"
    click_button "Login"
    expect(page).to have_content("Invalid login")
  end
end
