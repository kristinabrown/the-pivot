class BeerCategory < ActiveRecord::Base
  belongs_to :beer
  belongs_to :category
end
