require "rails_helper"

feature "any user is able to see" do 
  
  context "while not signed in" do
    
    before(:each) do 
      @store = Store.create(name: "Lunar Landing")
      @category1 = Category.create(name: "space")
      @category2 = Category.create(name: "kids")
      
      @store.items.create(name: "moon rock", description: "rocky",
                          expiration_date: "Time.now + 10.days",
                          starting_price: 10,
                          active: true, 
                          category_id: @category1.id )
      @store.items.create(name: "toy", description: "fun for all",
                          expiration_date: "Time.now + 10.days",
                          starting_price: 10,
                          active: true, 
                          category_id: @category2.id )
    end
    
    it "clicks on browse button sees a category" do
      visit root_path
      click_link "Browse"
      click_link "space"
      
      expect(current_path).to eq("/all_items")
      expect(page).to have_content("moon rock")
    end
  end
end