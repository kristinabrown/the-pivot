class OrderBeer < ActiveRecord::Base
  belongs_to :beer
  belongs_to :order
end