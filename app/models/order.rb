class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_beers
  has_many :beers, through: :order_beers

  validates :user_id, presence: true
  validates :status, presence: true
  validates :total, presence: true
end
