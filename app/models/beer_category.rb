class BeerCategory < ActiveRecord::Base
  belongs_to :beer
  belongs_to :category
  
  validates :beer_id, presence: true
  validates :category_id, presence: true
end
