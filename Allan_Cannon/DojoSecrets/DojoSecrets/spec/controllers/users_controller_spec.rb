require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  before do
    @user = create(:user)
  end
  context "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access show" do
      get :show, user_id: @user
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access edit" do
      get :edit, user_id: @user
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access update" do
      patch :update, user_id: @user
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access destroy" do
      delete :destroy, user_id: @user
      expect(response).to redirect_to("/sessions/new")
    end
  end
  context "when signed in as the wrong user" do
    before do
      session[:user_id] = @user.id
    end
    it "cannot access profile page another user" do
      get :show, user_id: 1
      expect(response).to redirect_to("/users/#{@user.id}")
    end
    it "cannot access the edit page of another user" do
      get :edit, user_id: 1
      expect(response).to redirect_to("/users/#{@user.id}")
    end
    it "cannot update another user" do
      patch :update, user_id: 1
      expect(response).to redirect_to("/users/#{@user.id}")
    end
    it "cannot destroy another user" do
      delete :destroy, user_id: 1
      expect(response).to redirect_to("/users/#{@user.id}")
    end
  end
end
