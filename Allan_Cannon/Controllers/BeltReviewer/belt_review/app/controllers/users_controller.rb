class UsersController < ApplicationController
  def create

    # first tries to find a matching location
    location = Location.find_by(state:State.find(params[:state_id].to_i),name:params[:location_name])
    # if it can't find one, tries to create one
    unless location
      location = Location.create(state:State.find(params[:state_id].to_i), name:params[:location_name])
    end

    user = User.create(user_params.merge(location:location))

    if user.errors
      flash[:errors] = user.errors.full_messages
      redirect_to "/sessions/new"
    else
      session[:user_id] = user.id
      redirect_to "/events"
    end
  end

  def edit
    @user = current_user
    @states = State.all
  end

  def update
    # first tries to find a matching location
    location = Location.find_by(state:State.find(params[:state_id].to_i),name:params[:location_name])
    # if it can't find one, tries to create one
    unless location
      location = Location.create(state:State.find(params[:state_id].to_i), name:params[:location_name])
    end

    user = User.find(params[:user_id].to_i)
    user.update(user_params.merge(location:location))

    if user.errors.any?
      flash[:errors] = user.errors.full_messages
      redirect_to "/users/#{user.id}/edit"
    else
      redirect_to "/events"
    end
  end


  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation)
  end

end
