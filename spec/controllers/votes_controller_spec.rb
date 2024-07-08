# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  let(:valid_attributes) { { movie_id: movie.id, vote_type: 'up' } }
  let(:invalid_attributes) { { movie_id: nil, vote_type: 'up' } }

  before do
    sign_in user
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Vote" do
        expect {
          post :create, params: { vote: valid_attributes }
        }.to change(Vote, :count).by(1)
      end

      it "redirects to the root path" do
        post :create, params: { vote: valid_attributes }
        expect(response).to redirect_to(root_path)
      end

      it "sets a success notice" do
        post :create, params: { vote: valid_attributes }
        expect(flash[:notice]).to eq(I18n.t('notices.vote_success'))
      end
    end

    context "with invalid params" do
      it "does not create a new Vote" do
        expect {
          post :create, params: { vote: invalid_attributes }
        }.not_to change(Vote, :count)
      end

      it "redirects to the root path" do
        post :create, params: { vote: invalid_attributes }
        expect(response).to redirect_to(root_path)
      end

      it "sets an error alert" do
        post :create, params: { vote: invalid_attributes }
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:vote) { create(:vote, user: user, movie: movie, vote_type: 'up') }

    it "destroys the requested vote" do
      expect {
        delete :destroy, params: { id: vote.id }
      }.to change(Vote, :count).by(-1)
    end

    it "redirects to the root path" do
      delete :destroy, params: { id: vote.id }
      expect(response).to redirect_to(root_path)
    end

    it "sets a success notice" do
      delete :destroy, params: { id: vote.id }
      expect(flash[:notice]).to eq(I18n.t('notices.unvote_success'))
    end

    context "when destroy fails" do
      before do
        allow(Vote).to receive(:find).and_return(vote)
        allow(vote).to receive(:destroy).and_return(false)
      end

      it "redirects to the root path" do
        delete :destroy, params: { id: vote.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
