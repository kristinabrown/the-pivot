class Item < ActiveRecord::Base
  
  belongs_to :store
  belongs_to :category
  has_many :bids
  
  validates :name, presence: true
  validates :description, presence: true
  validates :starting_price, presence: true
  validates :expiration_date, presence: true
  validates :store_id, presence: true
  validates :category_id, presence: true
  
  has_attached_file :attachment, default_url: "default-item.png",
                                 storage: :s3,
                                 bucket: ENV['bucket'],
                                 s3_credentials: { access_key_id: ENV["access_key_id"],
                                                   secret_access_key: ENV["secret_access_key"] }

  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/
  
  def expired?
    expiration_date < Time.now
  end

  def highest_bid
    if bids.any?
      Bid.where(item_id: id).maximum(:current_price)
    else
      starting_price
    end
  end
  
  def highest_bidder_id
    Bid.where(item_id: id).order(current_price: :desc).first.user_id
  end

  def available?
    active == true
  end
  
  def store_slug
    Store.find(store_id).slug
  end
end
