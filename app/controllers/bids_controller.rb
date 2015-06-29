class BidsController < ApplicationController

  def create
    bid = Bid.new(bid_params)
    if bid.item.highest_bid < params["bid"]["current_price"].to_i
      bid.save
      email_losers(bid)
      redirect_to users_path
    else 
      flash[:errors] = "Invalid bid!"
      redirect_to users_path
    end
  end
  
  def update
    bid = Bid.find(params[:id])
    if bid.item.highest_bid < params["bid"]["current_price"].to_i
      bid.update(current_price: params["bid"]["current_price"])
      email_losers(bid)
      redirect_to users_path
    else
      flash[:errors] = "Invalid bid!"
      redirect_to users_path
    end
  end

  private
    def bid_params
      params.require(:bid).permit(:item_id, :user_id, :current_price)
    end

    def email_losers(bid)
      bid.losers.each do |loser|
      BidMailer.outbid_email(loser, bid).deliver_later
      end
    end
end
