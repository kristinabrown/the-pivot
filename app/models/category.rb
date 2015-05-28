class Category < ActiveRecord::Base
  has_many :items

  validates :name, presence: true

  def self.sort_all
    order(:name)
  end
end
