require "rails_helper"

RSpec.describe "store admin can create edit and delet stores", type: :feature do 

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
  
  it "can add a new item" do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit admin_dashboard_path
    
    click_link "Create Item"
    
    fill_in "item[name]", with: "mood ring"
    fill_in "item[description]", with: "It tells your mood."
    fill_in "item[starting_price]", with: 10
    fill_in "item[expiration_date]", with: Time.now + 2.days
    click_button "Create Item"
    
    expect(current_path).to eq(store_items_path)
    expect(page).to have_content('mood ring') 
    expect(page).to have_content('Item succesfully created.') 
       
  end
  
  
end