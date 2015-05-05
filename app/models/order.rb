class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_beers
  has_many :beers, through: :order_beers

  validates :user_id, presence: true
  validates :status, presence: true,
                     inclusion: {in: %w(ordered completed cancelled paid)}
  validates :total, presence: true

  def statuses
    if status    == "ordered"
      ["paid", "cancelled"]
    elsif status == "paid"
      ["completed", "cancelled"]
    else
      []
    end
  end
  
  def self.user_name(order)
    User.where(id: order.user_id).pluck(:fullname).join
  end
  
  def self.user_email(order)
    User.where(id: order.user_id).pluck(:email).join
  end

  scope :ordered,   -> { where(status: "ordered") }
  scope :completed, -> { where(status: "completed") }
  scope :cancelled, -> { where(status: "cancelled") }
  scope :paid,      -> { where(status: "paid") }
end
