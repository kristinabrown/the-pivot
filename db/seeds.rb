# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, [ name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

class Seed
  # seed orders, users, beer
  def self.start
    new.generate
  end

  def generate
    create_users
    create_categories
    create_beer
    create_orders
  end


  def create_users
    users.each do |full_name, email, pw, role, phone, display_name|
      User.create(fullname: full_name, email: email, password: pw, role: role, phone: phone, display_name: display_name)
    end
    puts "Users: #{User.all.map(&:fullname).join(", ")} created."
  end

  def create_categories
    categories.each do |name, description|
      Category.create(name: name, description: description)
    end
    puts "Category: #{Category.all.map(&:name).join(", ")} created."
  end
  
  def create_beer
    rotator = (1..(categories.length)).to_a
    beer.each do |name, state, description, price|
      cat = Category.find_by(id: rotator.first)
      cat.beers.create(name: name, state: state, description: description, price: price)
      rotator.rotate!
    end
    puts "Beers: #{Beer.all.map(&:name).join(", ")} created."
  end

  def create_orders
    orders.each do |user_id, status, total|
      Order.create(user_id: user_id, status: status, total: total)
    end
    puts "Orders: #{Order.all.map(&:user_id).join(", ")} created."
  end


  private

   def beer
     [
      ["Big Tasty", true, "Poignant and personal", 400 ],
      ["Imperial Stout", true, "Generic Imperial stout", 450 ],
      ["KB Special", true, "Description", 350 ],
      ["Tracy Spacy", true, "Description", 500 ],
      ["Minnie Winny", true, "Description", 550 ],
      ["Pink Pilsner", true, "Description", 400 ],
      ["Kreamy Kolsch", true, "Description", 375 ],
      ["Les Faverage", true, "Description", 500 ],
      ["La-Brunson", true, "Description", 475 ],
      ["La-Bise", false, "Description", 300 ],
      ["Backside Montford", true, "Tasty and true", 200 ],
      ["Beer12", true, "Description", 400 ],
      ["Beer13", true, "Description", 450 ],
      ["Beer14", true, "Description", 900 ],
      ["Beer15", true, "Description", 250 ],
      ["Beer16", true, "Description", 600 ],
      ["Beer17", true, "Description", 400 ],
      ["Beer18", true, "Description", 375 ],
      ["Beer19", true, "Description", 475 ],
      ["Beer20", true, "Description", 725 ],
     ]
   end

   def users
     [
      ["Josh Cheek", "demo+josh@jumpstartlab.com", "password", 1, "9119119111", "josh"],
      ["Jorge Telez", "demo+jorge@jumpstartlab.com", "password", 0, "4044044404", "novohispano"],
      ["Jeff Cashmir", "demo+jeff@jumpstartlab.com", "password", 0, "1111111111", "j3"],
      ["Rachel Warbelow", "demo+rachel@jumpstartlab.com", "password", 0, "4044044404" ],
     ]
   end

   def orders
     [
      [1, "ordered", 1200],
      [2, "completed", 2200],
      [3, "cancelled", 400],
      [3, "paid", 10300],
      [4, "ordered", 2000],
      [4, "ordered", 800],
      [2, "completed", 1001],
      [1, "ordered", 2003],
      [3, "cancelled", 300],
      [1, "paid", 3000]
     ]
   end

   def categories
      [
        ["American Amber Ale", "American-style amber ales have medium-high to high maltiness with medium to low caramel character. They are characterized by American-variety hops, which produce medium hop bitterness, flavor and aroma. American ambers are usually darker in color, have more caramel flavor and less hop aromatics, and may have more body. This style was first made popular by brewers from California and the Pacific Northwest."],
        ["Pale Ale", "Fill in pale ale description"],
        ["Porter", "Fill in description"],
        ["Amber", "Fill in description"],
        ["Lager", "Fill in description"],
        ["IPA", "Fill in description"],
        ["Stout", "Fill in description"],
        ["Blonde", "Fill in description"],
        ["Hefferveisen", "Fill in description"],
      ]
   end

end

Seed.start