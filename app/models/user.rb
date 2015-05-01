class User < ActiveRecord::Base
  has_many :user_beers # can remove this and 
  has_many :beers, through: :user_beers #this
  has_many :orders

  validates :fullname, presence: true
  validates :email, presence: true,
                    length: { in: 5..50 },
                    uniqueness: true
  validates :display_name, allow_blank: true, 
                            length: {in: 2..32}

  has_secure_password
  enum role: %w(default admin)
  
  has_attached_file :avatar, styles: {thumb: '100x100>',
                                      square: '200x200#',
                                      medium: '300x300>'}, 
                              default_url: "default-medium.jpg",
                              storage: :s3,
                              bucket: ENV['bucket'],
                              s3_credentials: { access_key_id: ENV["access_key_id"],
                                                secret_access_key: ENV["secret_access_key"] }
                                      
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
