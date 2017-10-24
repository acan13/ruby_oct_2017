class LikesController < ApplicationController
  def create
    secret = Secret.find(params[:secret_id])
    Like.create(user:current_user,secret:secret)
    redirect_to "/secrets/index"
  end

  def destroy
    secret = Secret.find(params[:secret_id])
    like = Like.where(user:current_user).where(secret:secret).first
    like.destroy
    redirect_to "/secrets/index"
  end
end
