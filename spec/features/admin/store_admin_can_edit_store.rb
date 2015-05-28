require "rails_helper"

RSpec.describe "store admin can edit their own store", type: :feature do 

  before(:each) do
    @store = Store.create(name: "Lunar Landing")
    @admin = User.create!(fullname: "Jack Spade", 
                         email: "jack@sample.com",
                         display_name: "jackie",
                         phone: "222-333-4444",
                         password: "password",
                         street: "123 First Ave",
                         city: "Denver",
                         state: "CO",
                         zipcode: "80211",
                         credit_card: "4242424242424242",
                         cc_expiration_date: "2015-11-05", 
                         store_id: @store.id
                        ) 
    role = Role.create!(name: "store_admin")
    @admin.roles << role
  end
  
  it "can edit their own store" do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit admin_dashboard_path

    click_link "Edit Store"
    
    fill_in "store[name]", with: "The legendary Lunar Landing"
    click_button "Update Store"
    
    
    expect(page).to have_content('The legendary Lunar Landing') 
    expect(page).to have_content('Store was successfully updated')
  end
end