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
    Category.create(name: "Garage Sale Finds")
    Category.create(name: "Literature")
    Category.create(name: "Automobiles")
    Category.create(name: "Music")
    p 'Categories Created'
  end

  end

  def generate_stores
    store_name = "#{STORE_NAME.sample} #"
    
    p "Stores Created"
  end

  def generate_item_name
    begin
      item_name = "#{ITEM_NAME.sample} #{ITEM_TYPE).sample}"
    end while Item.exists?(name: item_name)

    item_name
  end

  def generate_items

  end


  def self.call
      new.call
  end
end

Seed.call
