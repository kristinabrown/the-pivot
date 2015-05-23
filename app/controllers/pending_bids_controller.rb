class PendingBidsController < ApplicationController
  
  def create
    item_id = params["bid"]["item_id"]
    price = params["bid"]["current_price"]
    @pending_bid.add_bid(item_id, price)
    session[:pending_bid] = @pending_bid.contents
    flash[:success] = "Login or Sign Up to post your bid."
    redirect_to login_path
  end
  
  
end