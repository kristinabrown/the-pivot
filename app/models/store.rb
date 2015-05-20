class Store < ActiveRecord::Base  
  validates :name, uniqueness: true
  validates :slug, uniqueness: true

  before_validation :generate_slug

  has_many :items

  def generate_slug
    self.slug = name.parameterize
  end
end
