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
      ["KB Special", true, "For the ladies", 350 ],
      ["Tracy Spacy", true, "You'll be laughing in no time", 500 ],
      ["Minnie Winny", true, "Put on your dancing shoes", 550 ],
      ["Pink Pilsner", true, "It's not actually pink...", 400 ],
      ["Kreamy Kolsch", true, "Hard, yet soft", 375 ],
      ["Les Faverage", true, "French for 'your favorite beer'", 500 ],
      ["La-Brunson", true, "Spanish for The Brunson", 475 ],
      ["La-Bise", false, "Portuguese for La-Brunson", 300 ],
      ["Backside Montford", true, "Tasty and true", 200 ],
      ["Duff", true, "Homer's go-to", 400 ],
      ["DAS BEER", true, "IT'S GERMAN", 450 ],
      ["Renegade", true, "Unleash your inner Cashmir", 900 ],
      ["Pliney the Elder", true, "Because 'Gandalph' was already taken", 250 ],
      ["Blind Pig IPA", true, "Oink Oink", 600 ],
      ["Hair on Your Chest Stout", true, "Darker than Turing with the lights turned off.", 400 ],
      ["Grandma's White Ale", true, "Drink it up, sonny.", 375 ],
      ["Black Brownout", true, "I forgot to write this description", 475 ],
      ["Beer", true, "It's beer", 725 ],
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
        ["Pale", "This is a pale ale"],
        ["Porter", "This is a porter"],
        ["Amber", "This is an amber"],
        ["Lager", "This is a LAGER"],
        ["IPA", "HOPPY IS HAPPY"],
        ["Blonde", "Insert blonde joke"],
      ]
   end

end

Seed.start