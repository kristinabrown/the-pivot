class Beer < ActiveRecord::Base
  has_many :user_beers
  has_many :users, through: :user_beers
  has_many :order_beers
  has_many :orders, through: :order_beers
  has_many :beer_categories
  has_many :categories, through: :beer_categories

  validates :name, presence: true
  validates :state, presence: true
  validates :description, presence: true
  validates :price, presence: true
  
  has_attached_file :attachment
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/
end
