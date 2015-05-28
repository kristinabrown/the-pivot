class BidMailer < ApplicationMailer
  
  def winning_email(user, order)
    @user = user
    @order = order
    
    mail(to: @user.email, subject: "Order confirmation for #{@order.item.name}")
  end
  
end
