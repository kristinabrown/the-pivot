class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def find_beer(beer_id)
    Beer.find(beer_id)
  end

  def add_beer(beer, quantity)
    if contents[beer.id.to_s]
      contents[beer.id.to_s]["quantity"] = contents[beer.id.to_s]["quantity"].to_i + quantity.to_i
      contents[beer.id.to_s]["beer_price"] = beer.price * contents[beer.id.to_s]["quantity"].to_i # just do ID and quantity and take logic elsewhere
    else
      contents[beer.id.to_s] = {"beer_name" => beer.name, "beer_price" => beer.price, "quantity" => quantity}
    end
  end

  def total
    contents.values.reduce(0) { |sum, value| sum += value["beer_price"].to_i }
  end

  def increase_quantity(beer)
    contents[beer.id.to_s]["quantity"] = contents[beer.id.to_s]["quantity"].to_i + 1
    contents[beer.id.to_s]["beer_price"] = beer.price * contents[beer.id.to_s]["quantity"].to_i # just do ID and quantity and take logic elsewhere
  end

  def decrease_quantity(beer)
    contents[beer.id.to_s]["quantity"] = contents[beer.id.to_s]["quantity"].to_i - 1
    contents[beer.id.to_s]["beer_price"] = beer.price * contents[beer.id.to_s]["quantity"].to_i # just do ID and quantity and take logic elsewhere
  end

  def delete_item(beer_id)
    contents.delete_if { |k, v| k == beer_id }
  end

  def all_beers
    contents.keys
    # contents.keys.map
  end
end