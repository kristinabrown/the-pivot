# require 'rails_helper'
# 
# RSpec.describe Category, type: :model do
#   let(:category) { Category.create(name: "India Pale Ale", 
#                                    description: "A hoppy beer") }
#   context "is valid" do
#     it "is valid with valid attributes" do
#       expect(category).to be_valid
#     end
#   end
# 
#   context "is invalid with invalid attributes" do
#     it "is invalid without name" do
#       category = Category.new(description: "A hoppy beer style")
# 
#       expect(category).to_not be_valid
#     end
# 
#     it "is invalid without description" do
#       category = Category.new(name: "India Pale Ale")
# 
#       expect(category).to_not be_valid
#     end
# 
#     it "responds to beers" do
#       expect(category.beers).to eq([])
#     end
#   end
# end