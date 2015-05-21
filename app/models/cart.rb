class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def find_item(item_id)
    Item.find(item_id.to_i)
  end
  
  def total_item_price(item_id, quantity)
    (find_item(item_id).price * quantity.to_i)/100
  end

  def add_item(item)
    contents[item.id] = item.id
  end

  def total
    contents.map { |k, v| total_item_price(k, v["quantity"]) }.reduce(:+)
  end

  def delete_item(item_id)
    contents.delete_if { |v, k| k == item_id.to_i }
  end

  # def all_beers
  #   contents.map do { |item| item.k}
  # end
end
