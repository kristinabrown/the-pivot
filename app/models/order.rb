class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_beers
  has_many :beers, through: :order_beers

  validates :user_id, presence: true
  validates :status, presence: true,
                     inclusion: {in: %w(ordered completed cancelled paid)}
  validates :total, presence: true
end
