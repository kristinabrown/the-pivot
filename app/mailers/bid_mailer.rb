class BidMailer < ApplicationMailer
  
  def winning_email(user, order)
    @user = user
    @order = order
    
    mail(to: @user.email, subject: "Order confirmation for #{@order.item.name}")
  end

  def outbid_email(user, bid)
    @user = user
    @bid = bid
    mail(to: @user.email, subject: "Someone has outbid you for #{@bid.item.name}")
  end

  def store_owner_email(order)
    @order = order

    mail(to: @order.store_owner_email, subject: "Someone purchased the #{@order.item.name}")
  end
end
