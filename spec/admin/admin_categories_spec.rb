require 'rails_helper'

RSpec.describe'admin categories' do
  context 'with admin logged in' do

    let(:admin) do
      User.create(full_name: "Skeeter McTyson",
                  password: "pw",
                  email: "skeeter@email.com",
                  phone_number: "111-111-1111"
                  role: 1)
    end

    xit 'displays the categories' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_categories_path
      expect(page).to have_content("Current Categories")
    end

    xit "redirects to new category path" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_categories_path
      click_link_or_button "New Category"
      expect(current_path).to eq(new_admin_category_path)
    end

    xit "creates a new category" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit new_admin_category_path
      fill_in "category[name]", with: "catty"
      fill_in "category[description]", with: "catty description"
      click_button "Create Category"
      expect(page).to have_content("catty")
      expect(page).to have_content("catty description")
    end

    xit "deletes a category" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit new_admin_category_path
      fill_in "category[name]", with: "category to delete"
      fill_in "category[description]", with: "whatever"
      click_button "Create Category"
      expect(page).to have_content("category to delete")
      expect(page).to have_content("whatever")
      click_link "Categories Index"

      click_button "Delete Category"
      expect(page).to_not have_content("category to delete")
      expect(page).to have_content("whatever")
    end

    xit "edits a category" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit new_admin_category_path
      fill_in "category[name]", with: "category to edit"
      fill_in "category[description]", with: "not important"
      click_button "Create Category"
      expect(page).to have_content("category to edit")
      expect(page).to have_content("whatever")
      click_link "Categories Index"

      click_button "Edit Category"
      fill_in "category[name]", with: "new category"
      fill_in "category[description]", with: "very important"
      expect(page).to_not have_content("category to edit")
      expect(page).to_not have_content("not important")
      expect(page).to have_content("new category")
      expect(page).to have_content("very important")
    end

  end

  context 'with default user logged in' do
    let(:user) do
      User.create(full_name: "Bum",
                  password: "pw",
                  email: "homeless@email.com",
                  phone_number: "111-111-1111"
                  role: 0)
    end

    xit "displays a 404 error" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit admin_categories_path
      expect(page).to have_content("404")
    end
  end

end