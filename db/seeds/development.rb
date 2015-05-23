class Seed

# 20 total businesses
# 10 categories
# 50 items per category --> for development: 20
# 100 registered customers, one with the following data:  for development --> 20 users
# Username: josh@turing.io
# Password: password

# for production -->
# 10 orders per registered customer
# 1 business admins per business
# Username: sam@turing.io
# Password: password
# 1 platform administrators
# Username: jorge@turing.io
# Password: password

  PICTURES = %w(baseballBR Beatles camera car1 car2 car3 celebrity2 celebrity3 celebrity4 
                classic-catwoman dress dress2 dress3, eclectic-desk accessories football
                guitar, lebron, lucycelebrity lunchbox phone pocket_watch star_trek1 star_trek2
                star_trek3 tea_service the_fonz toy1 toy2 toy3 vintage_logo)

  def call
    generate_categories
    generate_stores
    generate_users
    generate_items
  end

  def unique_email
    begin 
      unique_email = Faker::Internet.email
    end while User.exists?(email: unique_email) 

    unique_email
    #run this code while this email address is not unique.
    #Guarantees, valid, unique email address for each User
  end

  def generate_users
    User.create(fullname: "Josh Mejia", email: "josh@turing.io",
               phone: Faker::PhoneNumber.phone_number, password: "password",
               display_name: "oscar's dad", street: "123 First Ave", city: "Denver",
               state: "CO", zipcode: "80211",
               credit_card: "4242424242424242", cc_expiration_date: "2015-11-01" )

    60.times do
      User.create(
            fullname: Faker::Name.name, email: unique_email, password: 'password',
            display_name: Faker::Name.name.split.first, street: Faker::Address.street_address, 
            city: Faker::Address.city, state: Faker::Address.state, zipcode: Faker::Address.zip,
            credit_card:Faker::Business.credit_card_number, 
            cc_expiration_date: Faker::Business.credit_card_expiry_date,
            phone:Faker::PhoneNumber.phone_number       
      )
    end


    40.times do
      User.create(
            fullname: Faker::Name.name, email: unique_email, password: 'password',
            display_name: Faker::Name.name.split.first, street: Faker::Address.street_address, 
            apt_number: Faker::Address.secondary_address,
            city: Faker::Address.city, state: Faker::Address.state, zipcode: Faker::Address.zip,
            credit_card:Faker::Business.credit_card_number, 
            cc_expiration_date: Faker::Business.credit_card_expiry_date, 
            phone: Faker::PhoneNumber.phone_number 
      )
    end
    p 'Users Created'
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
    50.times do |i|
      picture = PICTURES[i % 31]
      item =  Item.new( 
              name: Faker::Commerce.product_name,
              description: Faker::Lorem.sentence,
              starting_price: Faker::Commerce.price + 1,
              expiration_date: Faker::Date.between(2.days.from_now, 15.days.from_now),
              store_id: (1..20).to_a.sample,
              category_id: (1..10).to_a.sample,
              active: true) 

              item.attachment = File.open("#{Rails.root}/app/assets/images/item_images/#{picture}.jpg")
              item.save!
    end
    p "Items Generated"
  end

  def self.call
    new.call
  end
end

Seed.call
