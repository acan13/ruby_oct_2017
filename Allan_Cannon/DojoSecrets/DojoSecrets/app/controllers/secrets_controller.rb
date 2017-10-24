class SecretsController < ApplicationController
  def index
    @secrets = Secret.all
  end

  def create
    secret = Secret.create(secret_params)
    if secret.errors.any?
      flash[:errors] = secret.errors.full_messages
    end
      redirect_to "/users/#{current_user.id}"
  end

  def destroy
    secret = Secret.find(params[:secret_id])
    if secret.user == current_user
      secret.destroy
    end
    redirect_to "/users/#{current_user.id}"
  end

  private

  def secret_params
    params.require(:secret).permit(:content).merge(user:current_user)
  end
end
