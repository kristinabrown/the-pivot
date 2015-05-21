class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  
  def item
    Item.find(item_id)
  end
  
end
