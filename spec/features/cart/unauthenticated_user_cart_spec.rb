require "rails_helper"

feature "an unauthenticated user accesses a cart" do 

  before(:each) do 
  category = Category.create({name: "Lager",
                                 description: "Yum"
                                 })

  beer1 = {name: "Titan",
          state: true,
          description: "aggressively hopped ipa",
          price: 400}
  category.beers.create(beer1)
  end

  scenario "successfully and adds one beer" do 
    visit root_path
    click_link "Drinks"
    click_link "Titan"
    click_button "Add to Basket"
    expect(current_path).to eq(add_to_carts_path)
    expect(page).to have_content("Titan")
    expect(page).to have_content("$4.00")
    expect(page).to have_content(1) 
  end

  xscenario "successfully adds two beers" do 

  end

  xscenario "successfully adds two different beers" do 

  end

  xscenario "unsuccessfully checks out" do 

  end
end