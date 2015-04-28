class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path
    else
      flash[:errors] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    # @user = User.find_by(email: user_params[:email])
  end

  private

 def user_params
    params.require(:user).permit(:fullname, 
                                 :display_name,
                                 :email,
                                 :phone, 
                                 :password, 
                                 :password_confirmation)
  end
end
