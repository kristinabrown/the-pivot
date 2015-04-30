class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_beer(beer, quantity)
    if contents.has_key?(beer.id)
      contents[beer.id][:quantity] += quantity
      contents[beer.id][:beer_price] = beer.price * contents[beer.id][:quantity]
    else
      contents[beer.id] = {beer_name: beer.name, beer_price: beer.price, quantity: quantity} 
    end
  end
end