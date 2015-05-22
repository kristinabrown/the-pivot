class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  
  def item
    Item.find(item_id)
  end
  
  def self.bid_exisits?(user_id, item_id)
    self.find_by(user_id: user_id, item_id: item_id)
  end
  
end
