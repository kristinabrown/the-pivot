class OrdersController < ApplicationController
  
  def create
    new_order = CreateOrder.new(params)
    order = Order.new(user_id: new_order.user_id, total: new_order.total, status: "ordered",)
    if order.save
      new_order.beers.each { |beer| order.beers << beer }
      redirect_to order_path(order)
    else 
      flash[:errors] = "Whoops! Something went wrong with your order."
      redirect_to add_to_carts_path
    end
    p params
  end

end