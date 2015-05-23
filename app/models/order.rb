class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :total, presence: true
  
  def item
    Item.find(item_id)
  end

end
