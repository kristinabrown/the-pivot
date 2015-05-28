class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  
  validates :current_price, presence: true
  validates :user_id, presence: true
  validates :item_id, presence: true
  
  def item
    Item.find(item_id)
  end

  def user
    User.find(user_id)
  end

  def losers
    losers = Bid.where(item_id: item.id).order(:current_price).pluck(:user_id)
    losers[0..-2].map{|loser| User.find(loser)}
  end
  
  def self.bid_exsits?(user_id, item_id)
    self.find_by(user_id: user_id, item_id: item_id)
  end
  
end
