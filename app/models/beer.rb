class Beer < ActiveRecord::Base
  # before_save :ensure_has_at_least_one_category
  
  has_many :order_beers
  has_many :orders, through: :order_beers
  has_many :beer_categories, dependent: :destroy
  has_many :categories, through: :beer_categories

  validates :name, presence: true, 
                   format: { with: /\A[a-zA-Z\d\D]+\z/ },
                   length: {in: 1..32},
                   uniqueness: true

  validates :state, :inclusion => {:in => [true, false]}
  validates :description, presence: true, 
                          format: { with: /\A[a-zA-Z\d\D]+\z/ }
  validates :price, presence: true
  
  has_attached_file :attachment, default_url: "beer_default_images.jpg",
                                 storage: :s3,
                                 bucket: ENV['bucket'],
                                 s3_credentials: { access_key_id: ENV["access_key_id"],
                                                   secret_access_key: ENV["secret_access_key"] } 
  
  
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/
  
  scope :all_available, -> { where(state: true) }
  
  def available?
    state == true
  end
  
  # def ensure_has_at_least_one_category
  #   if self.categories.count < 1
  #     errors.add(:beer, "A Beer must have at least one category")
  #     return false
  #   else
  #     return true
  #   end
  # end
end
