class SessionsController < ApplicationController

  def create
   @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to users_path # if default, go one place, if admin, elsewhere 
      #@users? ^
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