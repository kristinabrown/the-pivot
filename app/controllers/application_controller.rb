class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_admin?, :current_cart, :pending_bid
  before_action :current_cart, :pending_bid

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end
  def current_cart
    @cart ||= Cart.new(session[:cart])
  end
  
  def pending_bid
    @pending_bid ||= PendingBid.new(session[:pending_bid])
  end
  
  def current_permission
    @current_permission ||= Permissions.new(current_user)
  end

  def allow?
    current_permission.allow?(params[:controller], params[:action], params[:store])
  end

  def authorize!
    unless allow?
      flash[:errors] = "Something went wrong."
      redirect_to root_url
    end
  end
end
