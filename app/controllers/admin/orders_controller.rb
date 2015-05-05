class Admin::OrdersController < Admin::BaseController

  def index
    @orders = Order.all
  end

  def edit
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: params["order"]["status"])
    redirect_to admin_orders_path
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:user_id,
                                  :status,
                                  :total)
  end

end