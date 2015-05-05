class OrdersController < ApplicationController

  def create
    new_order = CreateOrder.new(params)
    order = Order.new(user_id: new_order.user_id, total: new_order.total, status: "ordered",)
    if order.save
      session[:cart].clear
      new_order.beers.each { |beer| order.beers << beer }
      new_order.quantities(order)
      redirect_to order_path(order)
    else
      flash[:errors] = "Whoops! Something went wrong with your order."
      redirect_to cart_items_path
    end
  end

  def index
    if current_user
      @orders = Order.where(user_id: current_user.id)
    else
      flash[:errors] = "Must be logged in to view orders"
      redirect_to login_path
    end
  end

  def show
    @order = Order.find(params[:id])
    if current_user && @order.user_id == current_user.id
      @order
    else
      flash[:errors] = "Oops, something went wrong"
      redirect_to "/404"
    end
  end
end