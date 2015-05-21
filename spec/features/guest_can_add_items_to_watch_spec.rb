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
      @store.items.create(name: "star dust", description: "rocky",
                          expiration_date: "Time.now + 10.days",
                          starting_price: 10,
                          active: true, 
                          category_id: @category.id )
    end
    it "can add an item to a watch list" do
      visit root_path
      click_link "Stores"
      click_link "Lunar Landing"
      click_link "moon rock"
      click_link_or_button "Watch"
      
      expect(page).to have_content("Watch List")
      expect(page).to have_content("moon rock")
    end
    
    it "can add two items to a watch list" do
      visit root_path
      click_link "Stores"
      click_link "Lunar Landing"
      click_link "moon rock"
      click_link_or_button "Watch"
      click_link "Stores"
      click_link "Lunar Landing"
      click_link "star dust"
      click_link_or_button "Watch"
  
      expect(page).to have_content("star dust")
    end
  end
end