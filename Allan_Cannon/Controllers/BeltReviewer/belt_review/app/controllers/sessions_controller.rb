class SessionsController < ApplicationController
  def new
    @states = State.all
  end

  def create
    user = User.find_by_email(params[:email].downcase).try(:authenticate, params[:password])
    unless user
      flash[:errors] = ["Invalid combination"]
      redirect_to "/sessions/new"
    else
      session[:user_id] = user.id
      redirect_to "/events"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to "/sessions/new"
  end
end
