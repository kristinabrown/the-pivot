class Seed
# 10 watch_list per registered customer

# 20 total businesses DONE
# 10 categories DONE
# 40/10 active items, 10 inactive per category DONE
# 100 registered customers, DONE
# Username: josh@turing.io, Password: password DONE

# 10 bids per registered customer DONE
# 1 business admins per business
# Username: sam@turing.io, Password: password DONE
# Username: jorge@turing.io, Password: password DONE

  PICTURES = %w(baseballBR Beatles camera car1 car2 car3 celebrity2 celebrity3 celebrity4 
                classic-catwoman dress dress2 dress3 eclectic-desk-accessories football
                guitar lebron lucycelebrity lunchbox phone pocket_watch star_trek1 star_trek2
                star_trek3 tea_service the_fonz toy1 toy2 toy3 vintage_logo)
  # STORES_IMAGES = %w(bakery bikes cabin_fever comics corner hardware hardware2 local raplhs records smiths)

  STORE_DESCRIPTORS =   ["Collectibles", "Antiques", "Basement Bargains", "Vintage Gear", "Good Ole Things",
                        "Nostalgia", "Knick-Knacks", "Attic", "Old Gear", "Classics", "Junkyard Goodies", 
                        "Discoveries", "Treasures", "Luxurious Accessories", "Designer Gems", "Biddables"]

  def call
    generate_categories
    generate_stores
    generate_new_items
    generate_expired_items
    generate_users
    generate_active_bids
    generate_inactive_bids
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

    User.create(fullname: "Sam Alghanmi", email: "sam@turing.io",
               phone: Faker::PhoneNumber.phone_number, password: "password",
               display_name: "dr. angular", street: "1510 Blake St", city: "Denver",
               state: "CO", zipcode: "80211",
               credit_card: "4242424242424242", cc_expiration_date: "2015-11-01", store_id: 1 )

    User.create(fullname: "Jorge Tellez", email: "jorge@turing.io",
               phone: Faker::PhoneNumber.phone_number, password: "password",
               display_name: "novohispano", street: "1510 Blake St", city: "Denver",
               state: "CO", zipcode: "80211",
               credit_card: "4242424242424242", cc_expiration_date: "2015-11-01" )

    User.create(fullname: "Test User", email: "test@example.com",
               phone: Faker::PhoneNumber.phone_number, password: "password",
               display_name: "tester", street: "1510 Blake St", city: "Denver",
               state: "CO", zipcode: "80211",
               credit_card: "4242424242424242", cc_expiration_date: "2015-11-01" )

    50.times do
      User.create(
            fullname: Faker::Name.first_name + " " + Faker::Name.last_name, email: unique_email, password: 'password',
            display_name: Faker::Name.first_name, street: Faker::Address.street_address, 
            city: Faker::Address.city, state: Faker::Address.state, zipcode: Faker::Address.zip,
            credit_card:Faker::Business.credit_card_number, 
            cc_expiration_date: Faker::Business.credit_card_expiry_date,
            phone:Faker::PhoneNumber.phone_number       
      )
    end

    50.times do
      User.create(
            fullname: Faker::Name.first_name + " " + Faker::Name.last_name, email: unique_email, password: 'password',
            display_name: Faker::Name.first_name, street: Faker::Address.street_address, 
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
    20.times do |i|
      store_descriptor = STORE_DESCRIPTORS[i % STORE_DESCRIPTORS.length]

      store = Store.create(
              name: Faker::Company.name + "'s #{store_descriptor}")
    end
    p "Stores Created"
  end

  def generate_new_items
    i = 0
    stores = Store.all

    Category.all.each do |category|  
      40.times do  
        store = stores[ i % stores.length]
        picture = PICTURES.sample

        item =  Item.new( 
                name: Faker::Commerce.product_name,
                description: Faker::Lorem.sentence,
                starting_price: Faker::Commerce.price + 1,
                expiration_date: Faker::Date.between(2.days.from_now, 15.days.from_now),
                store: store,
                category: category,
                active: true) 

        item.attachment = File.open("#{Rails.root}/app/assets/images/item_images/#{picture}.jpg")
        item.save!
        i += 1 
      end
    end
    p "New Items Generated"
  end

  def generate_expired_items
    i = 0
    stores = Store.all

    Category.all.each do |category| 
      10.times do 
        store = stores[ i % stores.length]
        picture = PICTURES.sample

        item =  Item.new( 
                name: Faker::Commerce.product_name,
                description: Faker::Lorem.sentence,
                starting_price: Faker::Commerce.price + 1,
                expiration_date: Faker::Time.between(20.days.ago, Time.now, :all),
                store: store,
                category: category,
                active: false) 

        item.attachment = File.open("#{Rails.root}/app/assets/images/item_images/#{picture}.jpg")
        item.save!
        i += 1 
             
      end
    end
    p "Expired Items Generated"
  end

  def generate_active_bids
    items = Item.where(active:true)
    
    User.all.each do |user|
      7.times do 
        item = items.shuffle.first
        Bid.create!(user_id: user.id, item_id: item.id, current_price: Faker::Commerce.price)
      end
    end
    p "Bids Created"
  end

  def generate_inactive_bids
    items = Item.where(active:false)
    
    User.all.each do |user|
      3.times do 
        item = items.shuffle.first
        Bid.create!(user_id: user.id, item_id: item.id, current_price: Faker::Commerce.price)
      end
    end
    p "Inactive Bids Created"
  end

  def self.call
    new.call
  end
end

Seed.call
