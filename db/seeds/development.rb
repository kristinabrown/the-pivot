class Seed

  def call
    generate_categories
    generate_stores
    generate_items
  end

  def generate_categories
    Category.create(name: "Sports Memorabilia")
    Category.create(name: "TV & Movie Classics")
    Category.create(name: "Luxury")
    Category.create(name: "Animation & Comics")
    Category.create(name: "Celebrity")
    Category.create(name: "Vintage Clothing")
    Category.create(name: "Toys & Games")
    Category.create(name: "Literature")
    Category.create(name: "Automobiles")
    Category.create(name: "Music")
    p 'Categories Created'
  end

  def generate_stores
    20.times do
      store = Store.create(
              name: Faker::Company.name)
    end
    p "Stores Created"
  end

  def generate_items
    50.times do
      item =  Item.create( 
              name: Faker::Commerce.product_name,
              description: Faker::Lorem.sentence,
              starting_price: Faker::Commerce.price + 1,
              expiration_date: Faker::Date.between(2.days.from_now, 15.days.from_now),
              store_id: (1..20).to_a.sample,
              category_id: (1..10).to_a.sample,
              active: true )
    end
    p "Items Generated"
  end

  def self.call
      new.call
  end
end

Seed.call
