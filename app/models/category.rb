class Category < ActiveRecord::Base
  has_many :beer_categories
  has_many :beers, through: :beer_categories

  validates :name, presence: true
  validates :description, presence: true
end
