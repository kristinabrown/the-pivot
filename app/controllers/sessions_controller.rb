class SessionsController < ApplicationController

  def create
   @user = User.find_by(email: params[:session][:email])
    if @user != nil && @user.admin?
      session[:user_id] = @user.id
      redirect_to admin_beers_path
    elsif @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      if @cart.contents.empty?
        redirect_to users_path 
      else
        redirect_to cart_items_path
      end
    else
      flash[:errors] = "Invalid login"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end