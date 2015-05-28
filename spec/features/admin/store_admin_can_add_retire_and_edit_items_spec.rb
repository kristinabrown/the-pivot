require "rails_helper"

RSpec.describe "store admin can create edit and delet stores", type: :feature do 

  before(:each) do
    @store = Store.create(name: "Lunar Landing")
    @category = Category.create(name: "Space")
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
    select "Space", from: "item[category_id]"
    click_button "Create Item"
    
    expect(page).to have_content('mood ring') 
    expect(page).to have_content('Item has been created!')      
  end
  
  it "can edit an item" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    Item.create(name: "mood ring", description: "cool", starting_price: 100, expiration_date: Time.now + 1.day, category_id: @category.id, store_id: @store.id)
    
    visit admin_dashboard_path
    click_link "Edit Items"
    click_link "Edit"
    
    fill_in "item[name]", with: "moon rock"
    fill_in "item[description]", with: "It tells your mood."
    fill_in "item[starting_price]", with: 10
    fill_in "item[expiration_date]", with: Time.now + 2.days
    select "Space", from: "item[category_id]"
    click_button "Update Item"
    
    
    expect(page).to have_content('moon rock') 
    expect(page).to have_content('Item has been updated!')    
  end
  
  it "can delete an item" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    Item.create(name: "mood ring", description: "cool", starting_price: 100, expiration_date: Time.now + 1.day, category_id: @category.id, store_id: @store.id)
    
    visit admin_dashboard_path
    click_link "Edit Items"
    expect(page).to have_content('mood ring') 
    click_link "Delete"

    expect(page).to_not have_content('mood ring') 
    expect(page).to have_content('Item has been deleted!')    
  end
end