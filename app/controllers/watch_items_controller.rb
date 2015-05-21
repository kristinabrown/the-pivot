class WatchItemsController < ApplicationController
  def create
    item_id = params[:order][:item_id]
    item    = @cart.find_item(item_id)
    if item.available?
      @cart.add_item(item)
      session[:cart] = @cart.contents
      render :index
    else
      flash[:errors] = "The #{item.name} is unavailable."
      redirect_to stores_path
    end
  end

  def destroy
    @cart.delete_item(params['item']['item_id'])
    render :index
  end

  def increase
    item = @cart.find_item(params["item"]["item_id"])
      @cart.increase_quantity(item)
    render :index
  end

  def decrease
    item = @cart.find_item(params["item"]["item_id"]) 
      @cart.decrease_quantity(item)
    render :index
  end
end
