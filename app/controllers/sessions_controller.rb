class SessionsController < ApplicationController
  def create
   @user = User.find_by(email: params[:session][:email])
    if @user != nil && @user.admin?
      session[:user_id] = @user.id
      redirect_to admin_dashboard_path
    elsif @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      if @pending_bid.contents.empty?
        redirect_to users_path
      else
        Bid.create(user_id: current_user.id, item_id: @pending_bid.contents["bid"]["item"].to_i, current_price: @pending_bid.contents["bid"]["price"].to_i)
        flash[:success] = "Your bid successfully posted!"
        session[:pending_bid].clear
        redirect_to users_path
      end
    else
      flash[:errors] = "Invalid login"
      render :new
    end
  end

  def destroy
    session.clear
    flash.now[:success] = "Successfully logged out."
    redirect_to root_path
  end
end
