class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end
  
  def add_beer(beer, quantity)
    if contents.has_key?(beer.id.to_s)
      contents[beer.id.to_s]["quantity"] = contents[beer.id.to_s]["quantity"].to_i + quantity.to_i
      contents[beer.id.to_s]["beer_price"] = beer.price * contents[beer.id.to_s]["quantity"].to_i # just do ID and quantity and take logic elsewhere
    else
      contents[beer.id.to_s] = {"beer_name" => beer.name, "beer_price" => beer.price, "quantity" => quantity}
    end
  end
  
  def total # use reduce
    total = 0
    contents.each { |k, v| total += v["beer_price"].to_i }
    total
  end

  def all_beers
    contents.keys
    # contents.keys.map
  end
end