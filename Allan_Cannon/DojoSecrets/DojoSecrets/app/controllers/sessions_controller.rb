class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]
  
  def new
    #login page
  end

  def create
    @user = User.find_by_email(user_params[:email].downcase).try(:authenticate, user_params[:password])
    unless @user
      flash[:errors] = ["Invalid combination"]
      redirect_to "/sessions/new"
    else
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}"
    end
  end

  def destroy
    if current_user
      session.delete(:user_id)
    end
    redirect_to "/sessions/new"
  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation)
  end
end
