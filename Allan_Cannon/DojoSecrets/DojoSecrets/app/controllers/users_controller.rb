class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]
  before_action :user_authorization, except: [:new, :create]


  def new

  end

  def show
  end

  def edit
  end

  def update
    user = User.find(current_user.id)
    user.assign_attributes(user_params)
    if user.changed?
      user.update(user_params)
      if user.errors.any?
        flash[:errors] = user.errors.full_messages
        redirect_to "/users/#{current_user.id}/edit"
      else
        flash[:success] = true
        redirect_to "/users/#{current_user.id}"
      end
    else
      flash[:errors] = ["No fields were changed"]
      redirect_to "/users/#{current_user.id}/edit"
    end
  end

  def create
    user = User.create(user_params)
    if user.errors.any?
      flash[:errors] = user.errors.full_messages
      redirect_to "/users/new"
    else
      session[:user_id] = user.id
      redirect_to "/sessions/new"
    end
  end

  def destroy
    if current_user.id == params[:user_id].to_i
      user = User.find(current_user.id)
      user.destroy
      session.delete(:user_id)
      redirect_to "/users/new"
    else
      redirect_to "users/#{current_user.id}"
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation)
  end

  def user_authorization
    unless current_user.id == params[:user_id].to_i
      redirect_to "/users/#{current_user.id}"
    end
  end
end
