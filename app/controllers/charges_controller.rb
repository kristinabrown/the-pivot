class ChargesController < ApplicationController
  
  def index
    @order = Order.find(params["order_id"])
  end

  def create
    @order = current_user.orders.last

    customer = Stripe::Customer.create(
      email: stripe_params[:stripeEmail],
      card:  stripe_params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,
      amount:       @order.to_cents(@order.total),
      description:  "Beer LLC",
      currency:     "usd"
    )

    @order.set_status_to_paid if charge
    
    redirect_to order_path(@order)
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path
  end

  private

  def stripe_params
    params.permit(:stripeEmail, :stripeToken)
  end
  
end