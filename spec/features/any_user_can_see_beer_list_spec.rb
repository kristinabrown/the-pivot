require "rails_helper"

feature "any user is able to see" do 

  before(:each) do 
  category = Category.create({name: "Lager",
                              description: "Yum"
                                 })
  category2 = Category.create({name: "IPA",
                              description: "Delicious"

    })

  category3 = Category.create({name: "Stout",
                              description: "Bold"
    })

  beer1 = {name: "Titan",
          state: true,
          description: "aggressively hopped ipa",
          price: 350}
  beer2 = {name: "Aud Blonde",
          state: true,
          description: "blonde ale",
          price: 450
  }
  beer3 = {name: "STS Pils",
          state: true,
          description: "Pilsner",
          price: 275
  }
  category.beers.create(beer1)
  category2.beers.create(beer2)
  category3.beers.create(beer3)
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

  scenario "the beers associated with a category" do 
    visit beers_path
    click_button "Lager"
    expect(page).to have_content("Titan")
    page.all("#lager_beers", :visible => true)
    page.all("#ipa_beers", :visible => false)
    page.all("#stout_beers", :visible => false)
  end
end