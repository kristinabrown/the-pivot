# require "rails_helper"
# 
# feature "an unauthenticated user accesses a cart" do 
# 
#   before(:each) do 
#   category = Category.create({name: "Lager",
#                                  description: "Yum"
#                                  })
# 
#   beer1 = {name: "Titan",
#           state: true,
#           description: "aggressively hopped ipa",
#           price: 400}
#           
#   beer2 = {name: "Yeti",
#           state: true,
#           description: "Not aggressively hopped ipa",
#           price: 500}
#   category.beers.create(beer1)
#   category.beers.create(beer2)
#   end
# 
#   scenario "successfully and adds one beer" do 
#     visit root_path
#     click_link "Drinks"
#     click_link "Titan"
#     click_button "Add to Basket"
#     expect(current_path).to eq(cart_items_path)
#     expect(page).to have_content("Titan")
#     expect(page).to have_content("$4.00")
#     expect(page).to have_content(1) 
#   end
# 
#   scenario "successfully adds two beers" do 
#     visit root_path
#     click_link "Drinks"
#     click_link "Titan"
#     click_button "Add to Basket"
#     
#     visit root_path
#     click_link "Drinks"
#     visit beers_path
#     click_link "Titan"
#     click_button "Add to Basket"
#     
#     expect(current_path).to eq(cart_items_path)
#     expect(page).to have_content("Titan")
#     expect(page).to have_content("$8.00")
#     expect(page).to have_content(2) 
#   end
# 
#   scenario "successfully adds two different beers" do
#     visit root_path
#     click_link "Drinks"
#     click_link "Titan"
#     click_button "Add to Basket"
#     
#     visit beers_path
#     click_link "Yeti"
#     click_button "Add to Basket"
# 
#     expect(current_path).to eq(cart_items_path)
#     expect(page).to have_content("Titan")
#     expect(page).to have_content("Yeti")
#     expect(page).to have_content("$9.00")
#     expect(page).to have_content(1)  
#   end
#   
#   scenario "successfully deletes an item" do
#     visit root_path
#     click_link "Drinks"
#     click_link "Titan"
#     click_button "Add to Basket"
#     
#     visit beers_path
#     click_link "Yeti"
#     click_button "Add to Basket"
# 
#     expect(page).to have_content("Titan")
#     
#     first(:link, "remove item").click
#     expect(page).to_not have_content("Titan")
#     expect(page).to_not have_content("$4.00")
#   end
#   
#   scenario "successfully increases an item" do
#     visit root_path
#     click_link "Drinks"
#     click_link "Titan"
#     click_button "Add to Basket"
# 
#     expect(page).to have_content("Titan")
#     expect(page).to have_content("1")
#     
#     first(:button, "+").click
#     expect(page).to have_content("Titan")
#     expect(page).to have_content("2")
#     expect(page).to have_content("$8.00")
#   end
#   
#   scenario "successfully decreases an item" do
#     visit root_path
#     click_link "Drinks"
#     click_link "Titan"
#     click_button "Add to Basket"
# 
#     expect(page).to have_content("Titan")
#     expect(page).to have_content("1")
#     
#     first(:button, "+").click
#     first(:button, "-").click
#     
#     expect(page).to have_content("Titan")
#     expect(page).to have_content("1")
#     expect(page).to have_content("$4.00")
#   end
# 
#   scenario "unsuccessfully checks out" do
#     visit root_path
#     click_link "Drinks"
#     click_link "Titan"
#     click_button "Add to Basket"
#     
#     visit beers_path
#     click_link "Yeti"
#     click_button "Add to Basket"
# 
#     expect(current_path).to eq(cart_items_path)
#     expect(page).to have_content("Titan")
#     expect(page).to have_content("Yeti")
#     expect(page).to have_content("$9.00")
#     expect(page).to have_content(1)   
# 
#     expect(page).to have_content("Please log in to checkout.")
#   end
# end