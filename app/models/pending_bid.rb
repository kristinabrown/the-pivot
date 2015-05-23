class PendingBid
  attr_reader :contents
  
  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_bid(item_id, price)
    contents["bid"] = { "item" => item_id, "price" => price}
  end
  
end