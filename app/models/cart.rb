class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def find_item(item_id)
    Item.find(item_id.to_i)
  end

  def add_item(item)
    contents[item.id] = item.id
  end

  def delete_item(item_id)
    contents.delete_if { |v, k| k == item_id.to_i }
  end
end
