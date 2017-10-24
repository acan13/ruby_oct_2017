class InvitationsController < ApplicationController

  def create
    invitee = User.find(params[:invitee_id].to_i)
    inviter = current_user

    Ignored.find_by(ignorer:inviter,ignoree:invitee).try(:destroy)

    invite = Invitation.create(inviter:inviter,invitee:invitee)

    if invite.errors.any?
      flash[:errors] = invite.errors.full_messages
    end

    redirect_to :back
  end

  def destroy
  end


end
