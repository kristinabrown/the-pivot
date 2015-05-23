class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_admin?, :current_cart, :pending_bid
  before_action :current_cart, :pending_bid, :expire_items, :create_order

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  # def current_admin?
  #   current_user && current_user.admin?
  # end

  def current_cart
    @cart ||= Cart.new(session[:cart])
  end
  
  def pending_bid
    @pending_bid ||= PendingBid.new(session[:pending_bid])
  end
  
  def create_order
    Item.all.each do |item|
      if item.expired? && Bid.find_by(item_id: item.id)
        bid = Bid.find_by(item_id: item.id)
        Order.find_or_create_by(user_id: bid.user_id, item_id: item.id, total: bid.current_price)
        item.update(paid: true)
      end
    end
  end
  
  def expire_items
    Item.all.each do |item|
      if item.expired?
        item.update(active: false)
      end
    end
  end
end
