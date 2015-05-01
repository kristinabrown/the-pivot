class OrdersController < ApplicationController
  
  def create
    new_order = CreateOrder.new(params)
    order = Order.new(user_id: new_order.user_id, total: new_order.total, status: "ordered",)
    if order.save
      session[:cart].clear
      new_order.beers.each { |beer| order.beers << beer }
      redirect_to order_path(order)
    else 
      flash[:errors] = "Whoops! Something went wrong with your order."
      redirect_to add_to_carts_path
    end
  end

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end
end