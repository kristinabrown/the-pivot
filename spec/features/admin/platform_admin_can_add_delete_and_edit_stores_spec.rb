require "rails_helper"

RSpec.describe "platform admin can create edit and delete stores", type: :feature do 

  before(:each) do 
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
                         cc_expiration_date: "2015-11-05"
                        ) 
    role = Role.create!(name: "platform_admin")
    @admin.roles << role
  end
  
  it "can add a new store" do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit admin_dashboard_path
    
    click_link "Create New Store"
    expect(current_path).to eq(new_store_path)
    
    fill_in "store[name]", with: "Lunar Landing"
    click_button "Create Store"
    
    expect(current_path).to eq('/stores')
    expect(page).to have_content('Lunar Landing')    
  end
  
  it "can edit a store" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    store = Store.create!(name: "Luny Landing")
    visit stores_path
    expect(page).to have_content("Luny Landing")
    
    click_link "Edit"
    fill_in "store[name]", with: "Lunar Landing"
    click_button "Update Store"
    
    expect(page).to have_content('Lunar Landing')    
  end
  
  it "can delete a store" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    store = Store.create!(name: "Luny Landing")
    visit stores_path
    expect(page).to have_content("Luny Landing")
    
    click_link "Delete"
    
    expect(current_path).to eq('/stores')
    expect(page).to_not have_content('Luny Landing')    
  end
  
end