require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
  end

  describe "#show" do
    it "responds successfully" do
      get :show, params: { id: @user.id }
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end

  describe "#new" do
    it "responds successfully" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end

  describe "#edit" do
    context "as an authorized user" do
      it "responds successfully" do
        log_in_as(@user)
        get :edit, params: { id: @user.id }
        expect(response).to be_success
        expect(response).to have_http_status "200"
      end
    end
    context "as an unauthorized user" do
      it "does not respond successfully" do
        get :edit, params: { id: @user.id }
        expect(response).to_not be_success
        expect(response).to_not have_http_status "200"
      end
    end
    context "as a wrong user" do
      it "should redirect edit" do
        log_in_as(@another_user)
        get :edit, params: { id: @user.id }
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      it "redirects to the login page" do
        patch :update, params: {id: @user.id, name: "Test User" }
        expect(response).to redirect_to accounts_login_url
      end
    end
    context "as a wrong user" do
      it "should redirect update" do
        log_in_as(@another_user)
        patch :update, params: {id: @user.id, name: "Test User" }
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "#destroy" do
    context "as a not login user" do
      it "should redirect destroy" do
        delete :destroy, params: {id: @user.id }
        expect(response).to redirect_to accounts_login_url
      end
    end
    context "as a wrong user" do
      it "should redirect destroy" do
        log_in_as(@another_user)
        delete :destroy, params: {id: @user.id }
        expect(response).to redirect_to root_url
      end
    end
  end
end
