class User < ActiveRecord::Base
  has_many :user_beers
  has_many :beers, through: :user_beers
  has_many :orders
  
  validates :fullname, presence: true
  validates :email, presence: true, 
                    length: {in: 5..50 },
                    uniqueness: true
  #validates :display_name, length: {in: 2..32}
  
  has_secure_password
  enum role: %w(default admin)
end