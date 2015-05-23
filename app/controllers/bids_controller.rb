class BidsController < ApplicationController

  def create
    bid = Bid.new(bid_params)
    if bid.item.starting_price < params["bid"]["current_price"].to_i
      bid.save
      redirect_to users_path
    else 
      flash[:errors] = "Invalid bid!"
      redirect_to users_path
    end
  end
  
  def update
    bid = Bid.find(params[:id])
    if bid.current_price < params["bid"]["current_price"].to_i
      bid.update(current_price: params["bid"]["current_price"])
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
end
