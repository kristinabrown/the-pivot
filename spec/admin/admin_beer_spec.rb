require 'rails_helper'

RSpec.describe'admin Beers' do
  context 'with admin logged in' do

    let(:admin) do
      User.create(full_name: "Skeeter McTyson",
                  password: "pw",
                  email: "skeeter@email.com",
                  phone_number: "111-111-1111"
                  role: 1)
    end

    xit 'displays the beers' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_beers_path
      expect(page).to have_content("Beers") # Probably want to change this to be more specific
    end

    xit "redirects to new beer path" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_beers_path
      click_link_or_button "New Beer"
      expect(current_path).to eq(new_admin_beer_path)
    end

    xit "creates a new beer" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit new_admin_beer_path
      fill_in "beer[name]", with: "DAS BEER"
      fill_in "beer[state]", with: true
      fill_in "beer[category_id]", with: 1
      fill_in "beer[description]", with: "High gravity, high flavor"
      fill_in "beer[price]", with: 4
      click_button "Create Beer"
      expect(page).to have_content("DAS BEER")
      expect(page).to have_content("High gravity, high flavor")
    end

    xit "deletes a beer" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit new_admin_beer_path
      fill_in "beer[name]", with: "beer to delete"
      fill_in "beer[state]", with: true
      fill_in "beer[category_id]", with: 1
      fill_in "beer[description]", with: "STALE"
      fill_in "beer[price]", with: 9
      click_button "Create Beer"
      expect(page).to have_content("beer to delete")
      click_link "Beers Index"

      click_button "Delete beer"
      expect(page).to_not have_content("beer to delete")
      expect(page).to_not have_content("STALE")
    end

    xit "edits a beer" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit new_admin_beer_path
      fill_in "beer[name]", with: "beer to edit"
      fill_in "beer[state]", with: true
      fill_in "beer[category_id]", with: 1
      fill_in "beer[description]", with: "YUCK"
      fill_in "beer[price]", with: 4
      click_button "Create Beer"
      expect(page).to have_content("beer to edit")
      click_link "Beers Index"

      click_button "Edit Beer"
      fill_in "beer[name]", with: "new beer"
      fill_in "beer[state]", with: true
      fill_in "beer[category_id]", with: 1
      fill_in "beer[description]", with: "YUM!"
      fill_in "beer[price]", with: 5
      expect(page).to_not have_content("beer to delete")
      expect(page).to have_content("YUM!")
      expect(page).to have_content("new beer")
    end

  end

  context 'with default user logged in' do
    let(:user) do
      User.create(full_name: "Bum",
                  password: "pw",
                  email: "homeless@email.com",
                  phone_number: "111-111-1111"
                  role: 1)
    end

    xit "displays a 404 error" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit admin_beers_path
      expect(page).to have_content("404")
    end
  end

end