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
end
