class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
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
      flash[:errors] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to users_path
  end

  private

 def user_params
    params.require(:user).permit(:fullname,
                                 :display_name,
                                 :email,
                                 :phone,
                                 :password,
                                 :password_confirmation,
                                 :avatar, :street, :city, :state, :zipcode,
                                 :credit_card, :cc_expiration_date)
  end

end
