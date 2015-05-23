class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  
  validates :current_price, presence: true
  validates :user_id, presence: true
  validates :item_id, presence: true
  
  def item
    Item.find(item_id)
  end
  
  def self.bid_exsits?(user_id, item_id)
    self.find_by(user_id: user_id, item_id: item_id)
  end
  
end
