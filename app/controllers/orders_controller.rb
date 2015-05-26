class OrdersController < ApplicationController
  def index
    if current_user
      @orders = Order.where(user_id: current_user.id)
    else
      flash[:errors] = "Must be logged in to view orders"
      redirect_to login_path
    end
  end
end