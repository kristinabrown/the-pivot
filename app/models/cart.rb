class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def find_beer(beer_id)
    Beer.find(beer_id.to_i)
  end
  
  def total_item_price(beer_id, quantity)
    (find_beer(beer_id).price * quantity.to_i)/100
  end

  def add_beer(beer, quantity)
    if contents[beer.id.to_s]
      contents[beer.id.to_s]["quantity"] = contents[beer.id.to_s]["quantity"].to_i + quantity.to_i
    else
      contents[beer.id.to_s] = {"quantity" => quantity}
    end
  end

  def total
    contents.map { |k, v| total_item_price(k, v["quantity"]) }.reduce(:+)
  end

  def increase_quantity(beer)
    contents[beer.id.to_s]["quantity"]   = contents[beer.id.to_s]["quantity"].to_i + 1
    contents[beer.id.to_s]["beer_price"] = beer.price * contents[beer.id.to_s]["quantity"].to_i
  end

  def decrease_quantity(beer)
    contents[beer.id.to_s]["quantity"]   = contents[beer.id.to_s]["quantity"].to_i - 1
    contents[beer.id.to_s]["beer_price"] = beer.price * contents[beer.id.to_s]["quantity"].to_i # just do ID and quantity and take logic elsewhere
  end

  def delete_item(beer_id)
    contents.delete_if { |k, v| k == beer_id }
  end

  def all_beers
    contents.keys
  end
end
