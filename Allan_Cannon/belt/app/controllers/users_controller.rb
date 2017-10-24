class UsersController < ApplicationController

  skip_before_action :require_login, only: :create
  before_action :user_authorization, except: [:temporary, :create, :index, :show, :professional_profile]

  def create
    user = User.create(user_params)

    if user.errors.any?
      flash[:errors] = user.errors.full_messages
      redirect_to "/sessions/new"
    else
      session[:user_id] = user.id
      redirect_to "/users"
    end
  end

  def show
    @user = User.find(params[:user_id].to_i)
  end

  def professional_profile
    @user = current_user
    @invitations = User.where(id:@user.invited_by).where.not(id:@user.invited).
      where.not(id:@user.ignored_users)
    @network = User.where(id:@user.invited).where(id:@user.invited_by)
  end

  def edit
    @user = current_user
  end

  def update
    user = User.find(current_user)
    user.assign_attributes(user_params)

    if user.changed?
      if user.save
        #change this line
        redirect_to "/professional_profile"
      else
        flash[:errors] = user.errors.full_messages
        redirect_to "/users/#{user.id}/edit"
      end
    else
      flash[:errors] = ["No fields were changed."]
      redirect_to "/users/#{user.id}/edit"
    end
  end

  def delete
  end

  def destroy
  end

  def index
    @possible_connections = User.where.not(id:current_user.id).
      where.not(id:current_user.invited_by.where.not(id:current_user.ignored_users)).where.not(id:current_user.invited)
  end

  def temporary
    #temporary method. Delete when added to project.
  end

  private

  def user_authorization
    unless current_user.id == params[:user_id].to_i
      puts '$$$$$$$$$$$$$$$$$$$'
      redirect_to "/users/#{current_user.id}"
      flash[:errors] = ["You do not have authorization to see information for that account."]
    end
  end

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation,:description)
  end
end
