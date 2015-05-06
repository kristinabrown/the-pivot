class OrderBeer < ActiveRecord::Base
  belongs_to :beer
  belongs_to :order
  
  def self.quantities(beer_id, order_id)
    where(order_id: order_id, beer_id: beer_id)
  end
  
  def self.line_item_subtotal(beer_price, quantity)
    (beer_price * quantity)/100
  end
end
