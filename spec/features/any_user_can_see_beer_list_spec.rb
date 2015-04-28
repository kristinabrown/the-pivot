require "rails_helper"

feature "any user is able to see" do 

  before(:each) do 
  category = Category.create({name: "Lager",
                                 description: "Yum"
                                 })

  beer1 = {name: "Titan",
          state: true,
          description: "aggressively hopped ipa",
          price: 350}
  category.beers.create(beer1)
  end

  scenario "the beer list" do 
    visit root_path
    click_link "Drinks"
    expect(page).to have_content("Lager")
  end

  scenario "a single beer" do 
    visit beers_path
    click_link "Titan"
    expect(page).to have_content("Titan")
    expect(page).to have_content("aggressively hopped ipa")
  end

  xscenario "the beers associated with a category" do 
    # there are 3 categories
    # beers are associated with each category
    # javascript
  end
end