require 'rails_helper'

RSpec.describe'admin orders' do
  context 'with admin logged in' do

    let(:admin) do
      User.create(full_name: "Kristinnie",
                  password: "pw",
                  email: "group@email.com",
                  phone_number: "111-111-1111"
                  role: 1)
    end

    xit 'displays the orders' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_orders_path
      expect(page).to have_content("Orders") # Probably want to change this to be more specific
    end

    xit "redirects to new order path" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_orders_path
      click_link_or_button "New Order"
      expect(current_path).to eq(new_admin_order_path)
    end

    xit "creates a new order" do # Will an admin need to create an order? / will they have a user_id
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit new_admin_order_path
      fill_in "order[user_id]", with: 1 # Might have to create a user earlier in the test
      fill_in "order[status]", with: "Ready"
      fill_in "order[total]", with: 2
      click_button "Create Order"
      expect(page).to have_content("Rando Order")
      expect(page).to have_content("Ready")
    end

    xit "deletes a order" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit new_admin_order_path
      fill_in "order[user_id]", with: 1
      fill_in "order[status]", with: #"In Progress" 
      fill_in "order[total]", with: 2
      click_button "Create Order"
      expect(page).to have_content("order to delete")
      click_link "Orders Index"

      click_button "Delete Order"
      expect(page).to_not have_content("order to delete")
    end

    xit "edits a order" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit new_admin_order_path
      fill_in "order[user_id]", with: 1
      fill_in "order[status]", with: #"In Progress" 
      fill_in "order[total]", with: 3
      click_button "Create Order"
      expect(page).to have_content("order to edit")
      click_link "Orders Index"

      click_button "Edit Order"
      fill_in "order[user_id]", with: 1
      fill_in "order[status]", with: #"In Progress" 
      fill_in "order[total]", with: 2
      expect(page).to_not have_content("order to edit")
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
      visit admin_orders_path
      expect(page).to have_content("404")
    end
  end

end