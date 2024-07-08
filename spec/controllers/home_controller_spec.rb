# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create(:user) }
  let!(:movies) { create_list(:movie, 10) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns the correct movies" do
      get :index
      expect(assigns(:movies)).to eq(movies.first(5))
    end

    it "paginates the movies correctly" do
      get :index, params: { page: 2 }
      expect(assigns(:movies).count).to eq(5)
    end

    it "returns a success response for paginated movies" do
      get :index, params: { page: 2 }
      expect(response).to be_successful
    end
  end
end
