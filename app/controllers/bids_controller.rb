class BidsController < ApplicationController

  def create
    bid = Bid.new(bid_params)
    if bid.save
      # bid = current_user.bid
      redirect_to users_path
    end
  end

  private
  def bid_params
    params.require(:bid).permit(:item_id, :user_id, :current_price)
  end
end
