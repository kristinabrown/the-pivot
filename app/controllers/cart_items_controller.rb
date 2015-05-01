class CartItemsController < ApplicationController
  def create
    beer = Beer.find(params[:order][:beer_id])
    if beer.state == true
      quantity = params[:order][:quantity]
      current_cart.add_beer(beer, quantity)
      session[:cart] = current_cart.contents 
      render :index
    else
      flash[:errors] = "The '#{beer.name}' is unavailable."
      render :index
    end
  end
  
  def update
    current_cart.delete_item(params['item']['beer_id'])
    render :index
  end
end