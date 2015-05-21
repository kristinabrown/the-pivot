class WatchItemsController < ApplicationController
  def create
    item_id = params[:order][:item_id]
    item    = @cart.find_item(item_id)
    if item.available?
      if @cart.contents[item_id]
        flash[:errors] = "The #{item.name} is already on watch!"
        render :index
      else
        @cart.add_item(item)
        session[:cart] = @cart.contents
        render :index
      end
    else
      flash[:errors] = "The #{item.name} is unavailable."
      redirect_to stores_path
    end
  end

  def destroy
    byebug
    @cart.delete_item(params['item']['item_id'])
    render :index
  end

end
