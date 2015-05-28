class User < ActiveRecord::Base
  has_many :orders
  has_many :bids
  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :fullname, presence: true, length: {in: 2..32}
  validates :email, presence: true, length: { in: 5..50 },
            uniqueness: true
  VALID_REGEX_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_format_of :email, with: VALID_REGEX_EMAIL, on: :create
  validates :display_name, allow_blank: true, length: {in: 2..32}
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates_format_of :zipcode, :with => /\A^\d{5}(-\d{4})?$\z/, :multiline => true, :message => "should be in the form 12345 or 12345-1234"
  validates :credit_card, presence: true, length: { minimum: 15, maximum: 16 }
  validates :cc_expiration_date, presence: true

  before_validation :clean_credit_card  #callback's allow you to alter the data, then the validations check the updated results

  has_secure_password

  has_attached_file :avatar, styles: {thumb: '100x100>',
                                      square: '200x200#',
                                      medium: '300x300>'},
                              default_url: "beast2.png",
                              storage: :s3,
                              bucket: ENV['bucket'],
                              s3_credentials: { access_key_id: ENV['access_key_id'],
                                                secret_access_key: ENV['secret_access_key'] }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  def platform_admin?
    roles.exists?(name: 'platform_admin')
  end

  def store_admin?
    roles.exists?(name: 'store_admin')
  end

  def registered_user?
    roles.exists?(name: 'registered_user')
  end 
  
  def store_slug
    Store.find(store_id).slug
  end
  
  def store
    Store.find(store_id)
  end

  protected
    def clean_credit_card
      credit_card.gsub!(/[^\d]/, "") unless credit_card.nil?
    end
end

