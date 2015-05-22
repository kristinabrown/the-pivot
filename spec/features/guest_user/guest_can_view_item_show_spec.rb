require "rails_helper"

feature "any user is able to see item show" do 
  
  context "while not signed in" do
    
    before(:each) do 
      @store = Store.create(name: "Lunar Landing")
      @category = Category.create(name: "space")
      @item = @store.items.create(name: "moon rock", description: "rocky",
                          expiration_date: "Time.now + 10.days",
                          starting_price: 10,
                          active: true, 
                          category_id: @category.id )
    end
    
    it "can visit the item show page" do
      visit root_path
      click_link "Stores"
      click_link "Lunar Landing"
      expect(current_path).to eq('/lunar-landing/items')
      click_link "moon rock"
      
      expect(current_path).to eq("/#{@item.id}/items/#{@item.id}")
      expect(page).to have_content("moon rock")
    end
  end
end