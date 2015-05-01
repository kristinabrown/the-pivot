class CartItemsController < ApplicationController

  def create
    beer = Beer.find(params[:order][:beer_id])
    quantity = params[:order][:quantity]
    current_cart.add_beer(beer, quantity)
    session[:cart] = current_cart.contents 
    render :index
  end
end