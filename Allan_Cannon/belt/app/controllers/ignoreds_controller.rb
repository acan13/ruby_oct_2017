class IgnoredsController < ApplicationController

  def create
    ignoree = User.find(params[:ignoree_id])
    ignorer = current_user

    ignor = Ignored.create(ignorer:ignorer,ignoree:ignoree)

    if ignor.errors.any?
      flash[:errors] = ignor.errors.full_messages
    end

    redirect_to :back
  end
end
