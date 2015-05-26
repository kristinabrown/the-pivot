class Category < ActiveRecord::Base
  belongs_to :item

  validates :name, presence: true

  def self.sort_all
    order(:name)
  end
end
