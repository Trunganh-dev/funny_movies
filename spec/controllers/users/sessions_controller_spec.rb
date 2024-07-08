# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  let(:user) { create(:user) }

  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "POST #create" do
    context "with existing user" do
      let(:valid_attributes) { { user: { email: user.email, password: user.password } } }

      it "signs in the user" do
        post :create, params: valid_attributes
        expect(response).to redirect_to(root_path)
      end

      it "returns success response" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:found) # 302 Redirect
      end
    end

    context "with new user" do
      let(:new_user_attributes) {
        { user: { email: "newuser@example.com", password: "password", password_confirmation: "password" } }
      }

      it "creates a new user" do
        expect {
          post :create, params: new_user_attributes
        }.to change(User, :count).by(1)
      end

      it "signs in the new user" do
        post :create, params: new_user_attributes
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { user: { email: user.email, password: "wrongpassword" } } }

      it "does not sign in the user" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:ok)
      end

      it "does not set current user" do
        post :create, params: invalid_attributes
        expect(controller.current_user).to be_nil
      end

      it "returns an alert message" do
        post :create, params: invalid_attributes
        expect(flash[:alert]).to be_present
      end
    end
  end
end
