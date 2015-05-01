class Beer < ActiveRecord::Base
  has_many :order_beers
  has_many :orders, through: :order_beers
  has_many :beer_categories
  has_many :categories, through: :beer_categories

  validates :name, presence: true
  validates :state, :inclusion => {:in => [true, false]}
  validates :description, presence: true
  validates :price, presence: true
  
  has_attached_file :attachment, default_url: "beer_default_images.jpg",
                                 storage: :s3,
                                 bucket: ENV['bucket'],
                                 s3_credentials: { access_key_id: ENV["access_key_id"],
                                                   secret_access_key: ENV["secret_access_key"] } 
  
  
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/
end
