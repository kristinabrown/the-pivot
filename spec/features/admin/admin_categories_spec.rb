# require 'rails_helper'
# 
# RSpec.describe'admin categories' do
#   context 'with admin logged in' do
# 
#     let(:admin) do
#       User.create(fullname: "Skeeter McTyson",
#                   password: "pw",
#                   email: "skeeter@email.com",
#                   phone: "111-111-1111",
#                   role: 1)
#     end
# 
#     it 'displays the categories' do
#       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
#       visit admin_categories_path
#       expect(page).to have_content("Current Categories")
#     end
# 
#     it "redirects to new category path" do
#       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
#       visit admin_categories_path
#       click_link_or_button "New Category"
#       expect(current_path).to eq(new_admin_category_path)
#     end
# 
#     it "creates a new category" do
#       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
#       visit new_admin_category_path
#       fill_in "category[name]", with: "catty"
#       fill_in "category[description]", with: "catty description"
#       click_button "Create Category"
#       expect(page).to have_content("catty")
#       expect(page).to have_content("catty description")
#     end
# 
#     it "deletes a category" do
#       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
#       visit new_admin_category_path
#       fill_in "category[name]", with: "category to delete"
#       fill_in "category[description]", with: "whatever"
#       click_button "Create Category"
#       expect(page).to have_content("category to delete")
#       expect(page).to have_content("whatever")
#       expect(current_path).to eq(admin_categories_path)
# 
#       click_link "Delete Category"
#       expect(page).to_not have_content("category to delete")
#       expect(page).to_not have_content("whatever")
#     end
# 
#     it "edits a category" do
#       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
#       visit new_admin_category_path
#       fill_in "category[name]", with: "category to edit"
#       fill_in "category[description]", with: "not important"
#       click_button "Create Category"
#       expect(page).to have_content("category to edit")
#       expect(page).to have_content("not important")
# 
#       click_link "Edit Category"
#       fill_in "category[name]", with: "new category"
#       fill_in "category[description]", with: "very important"
#       click_button "Update Category"
#       expect(page).to_not have_content("category to edit")
#       expect(page).to_not have_content("not important")
#       expect(page).to have_content("new category")
#       expect(page).to have_content("very important")
#     end
# 
#     it "assigns an beer to a category" do
#       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
#       pilsner = Category.create(name: "pilsner", description: "Mmmmm... pils")
#       beer = Beer.create(name: "Hoptageous", state: true, description: "Mmmmmmm", price: 3)
#       visit edit_admin_beer_path(beer)
#       page.check("pilsner")
#       click_button("Update Beer")
#       expect(current_path).to eq(admin_beer_path(beer))
#       expect(page).to have_content("pilsner")
#     end
# 
#   end
# 
#   context 'with default user logged in' do
#     let(:user) do
#       User.create(fullname: "Bum",
#                   password: "pw",
#                   email: "homeless@email.com",
#                   phone: "111-111-1111",
#                   role: 0)
#     end
# 
#     it "displays a 404 error" do
#       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
#       visit admin_categories_path
#       expect(page).to have_content("404")
#     end
#   end
# end