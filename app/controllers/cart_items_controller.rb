class CartItemsController < ApplicationController
  def create
    beer_id = params[:order][:beer_id]
    beer = @cart.find_beer(beer_id)
    if beer.available?
      quantity = params[:order][:quantity]
      @cart.add_beer(beer, quantity)
      session[:cart] = @cart.contents 
      render :index
    else
      flash[:errors] = "The '#{beer.name}' is unavailable."
      render :index
    end
  end
  
  def update
    @cart.delete_item(params['item']['beer_id'])
    render :index
  end
  
  def increase
    beer = @cart.find_beer(params["item"]["beer_id"])
    @cart.increase_quantity(beer)
    render :index
  end
  
  def decrease
    beer = @cart.find_beer(params["item"]["beer_id"])
    @cart.decrease_quantity(beer)
    render :index
  end
end
