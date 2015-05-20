class Category < ActiveRecord::Base
  belongs_to :item

  validates :name, presence: true
end
