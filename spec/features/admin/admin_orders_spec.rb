require 'rails_helper'

RSpec.describe'admin orders' do
  context 'with admin logged in' do

    let(:admin) do
      User.create(fullname: "Kristinnie",
                  password: "pw",
                  email: "group@email.com",
                  phone: "111-111-1111",
                  role: 1)
    end

    it 'displays the orders' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_orders_path
      expect(page).to have_content("Orders") # Probably want to change this to be more specific
    end

    it "deletes a order" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      Order.create(status: "completed",
                   user_id: admin.id,
                   total: 10)
      visit admin_orders_path
      expect(page).to have_content("completed")
      click_link "Delete Order"
      expect(page).to_not have_content("completed")
    end

    it "edits a order" do
      Order.create(status: "completed",
                   user_id: admin.id,
                   total: 10)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_orders_path
      expect(page).to have_content("completed")
      click_link "Edit Order"
      # fill_in "order[user_id]", with: 1
      fill_in "order[status]", with: "paid"
      fill_in "order[total]", with: 7
      click_button "Update Order"
      expect(page).to_not have_content("completed")
      expect(page).to have_content(7)
      expect(page).to have_content("paid")
    end

  end

  context 'with default user logged in' do
    let(:user) do
      User.create(fullname: "Bum",
                  password: "pw",
                  email: "homeless@email.com",
                  phone: "111-111-1111",
                  role: 0)
    end

    it "displays a 404 error" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit admin_orders_path
      expect(page).to have_content("404")
    end
  end

end