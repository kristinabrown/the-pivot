require "rails_helper"

feature "any user is able to see" do 
  
  context "while not signed in" do
    
    before(:each) do 
      @store = Store.create(name: "Lunar Landing")
      @category = Category.create(name: "space")
      @store.items.create(name: "moon rock", description: "rocky",
                          expiration_date: "Time.now + 10.days",
                          starting_price: 10,
                          active: true, 
                          category_id: @category.id )
    end
    
    it "can see all stores" do
      visit root_path
      click_link "Shops"
      click_link "All Shops"
      
      expect(current_path).to eq('/stores')
      expect(page).to have_content("Lunar Landing")
    end
    
    it "can visit a store items page" do
      visit root_path
      click_link "Shops"
      click_link "Lunar Landing"
      
      expect(current_path).to eq('/lunar-landing/items')
      expect(page).to have_content("Lunar Landing")
    end
    
    it "can view items" do
      visit root_path
      click_link "Shops"
      click_link "Lunar Landing"
      
      expect(current_path).to eq('/lunar-landing/items')
      expect(page).to have_content("moon rock")
    end
  end
end

    

