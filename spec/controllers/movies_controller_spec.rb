# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { { url: "https://www.youtube.com/watch?v=abc123" } }
  let(:invalid_attributes) { { url: "" } }

  before do
    sign_in user

    # Default stub for any URL
    allow(VideoInfo).to receive(:new).and_raise(VideoInfo::UrlError)

    # Specific stub for valid URL
    allow(VideoInfo).to receive(:new).with(valid_attributes[:url]).and_return(
      instance_double(VideoInfo, title: "Test Title", description: "Test Description",
                                 thumbnail_medium: "test_thumb.jpg", video_id: "abc123")
    )
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Movie" do
        expect {
          post :create, params: { movie: valid_attributes }
        }.to change(Movie, :count).by(1)
      end

      it "redirects to the root path" do
        post :create, params: { movie: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "does not create a new Movie" do
        expect {
          post :create, params: { movie: invalid_attributes }
        }.not_to change(Movie, :count)
      end

      it "redirects to the new movie path" do
        post :create, params: { movie: invalid_attributes }
        expect(response).to redirect_to(new_movie_path)
      end
    end

    context "with URL error" do
      before do
        allow(VideoInfo).to receive(:new).with(invalid_attributes[:url]).and_raise(VideoInfo::UrlError)
      end

      it "redirects to the new movie path" do
        post :create, params: { movie: invalid_attributes }
        expect(response).to redirect_to(new_movie_path)
      end

      it "sets an invalid URL alert" do
        post :create, params: { movie: invalid_attributes }
        expect(flash[:alert]).to eq(I18n.t('notices.invalid_url'))
      end
    end

    context "with general error" do
      before do
        allow(VideoInfo).to receive(:new).with(invalid_attributes[:url]).and_raise(StandardError, "Test error")
      end

      it "redirects to the new movie path" do
        post :create, params: { movie: invalid_attributes }
        expect(response).to redirect_to(new_movie_path)
      end

      it "sets a general error alert" do
        post :create, params: { movie: invalid_attributes }
        expect(flash[:alert]).to eq(I18n.t('notices.general_error'))
      end
    end
  end
end
