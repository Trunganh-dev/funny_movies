# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "GET /users/sign_up" do
    it "returns a success response" do
      get new_user_registration_path
      expect(response).to be_successful
    end
  end

  describe "POST /users" do
    context "with valid parameters" do
      let(:valid_attributes) { { user: attributes_for(:user) } }

      it "creates a new User" do
        expect {
          post user_registration_path, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it "redirects to the root path" do
        post user_registration_path, params: valid_attributes
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { user: { email: "", password: "", password_confirmation: "" } } }

      it "does not create a new User" do
        expect {
          post user_registration_path, params: invalid_attributes
        }.not_to change(User, :count)
      end

      it "returns a success response (i.e. to display the 'new' template)" do
        post user_registration_path, params: invalid_attributes
        expect(response).to be_successful
      end
    end
  end

  describe "POST /users/sign_in" do
    context "with valid parameters" do
      let(:valid_attributes) { { user: { email: user.email, password: user.password } } }

      it "signs in the user" do
        post user_session_path, params: valid_attributes
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { user: { email: user.email, password: "wrongpassword" } } }

      it "does not sign in the user" do
        post user_session_path, params: invalid_attributes
        expect(response).to be_successful
      end
    end
  end
end
