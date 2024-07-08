# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:movie) {
    described_class.new(
      title: "Test Title",
      thumb_url: "http://example.com/thumb.jpg",
      video_id: "abc123",
      user: user
    )
  }

  let(:user) { create(:user) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(movie).to be_valid
    end

    it "is not valid without a title" do
      movie.title = nil
      expect(movie).not_to be_valid
    end

    it "is not valid without a thumb_url" do
      movie.thumb_url = nil
      expect(movie).not_to be_valid
    end

    it "is not valid without a video_id" do
      movie.video_id = nil
      expect(movie).not_to be_valid
    end

    context "when video_id is duplicated" do
      before do
        described_class.create!(
          title: "Test Title 2",
          thumb_url: "http://example.com/thumb2.jpg",
          video_id: "abc123",
          user: user
        )
      end

      it "is not valid" do
        expect(movie).not_to be_valid
      end

      it "adds an error on video_id" do
        movie.valid?
        expect(movie.errors[:video_id]).to include("has already been taken")
      end
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:votes).dependent(:destroy) }
  end

  describe "#embed_url" do
    it "returns the correct embed URL" do
      expect(movie.embed_url).to eq("https://www.youtube.com/embed/abc123?autoplay=0&amp;cc_load_policy=1&amp;controls=2&amp;hl=vi&amp;rel=0&amp;enablejsapi=1&amp;widgetid=1")
    end
  end

  describe "#is_voted_by?" do
    let(:vote) { create(:vote, user: user, movie: movie) }

    it "returns true if the user has voted" do
      vote
      expect(movie.is_voted_by?(user.id)).to be true
    end

    it "returns false if the user has not voted" do
      expect(movie.is_voted_by?(user.id)).to be false
    end

    it "returns false if user_id is blank" do
      expect(movie.is_voted_by?(nil)).to be false
    end
  end
end
