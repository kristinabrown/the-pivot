class User::OrdersController < User::BaseController
  
  def create
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id]) 
  end 
end