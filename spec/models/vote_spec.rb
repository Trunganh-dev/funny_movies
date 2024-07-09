# frozen_string_literal: true

# == Schema Information
#
# Table name: votes
#
#  id         :bigint           not null, primary key
#  vote_type  :integer          default("up"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_votes_on_movie_id_and_user_id  (movie_id,user_id) UNIQUE
#
# spec/models/vote_spec.rb
require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  let(:vote) {
    described_class.new(
      user: user,
      movie: movie,
      vote_type: 'up'
    )
  }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(vote).to be_valid
    end

    it "is not valid without a user" do
      vote.user = nil
      expect(vote).not_to be_valid
    end

    it "is not valid without a movie" do
      vote.movie = nil
      expect(vote).not_to be_valid
    end

    it "is not valid with a duplicate vote for the same movie by the same user" do
      described_class.create!(user: user, movie: movie, vote_type: 'up')
      expect(vote).not_to be_valid
    end

    it "is valid with a unique vote for the same movie by a different user" do
      another_user = create(:user, email: "another_user@example.com")
      new_vote = described_class.new(user: another_user, movie: movie, vote_type: 'up')
      expect(new_vote).to be_valid
    end

    it "is valid with a unique vote for a different movie by the same user" do
      another_movie = create(:movie, video_id: "another_video_id")
      new_vote = described_class.new(user: user, movie: another_movie, vote_type: 'up')
      expect(new_vote).to be_valid
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:movie) }
    it { is_expected.to belong_to(:user) }
  end

  describe "enum" do
    it "defines the enum for vote_type" do
      expect(described_class.vote_types).to eq({ "up" => 0, "down" => 1 })
    end

    it "is valid with 'up' vote_type" do
      expect(vote).to be_valid
    end

    it "is valid with 'down' vote_type" do
      vote.vote_type = 'down'
      expect(vote).to be_valid
    end

    it "does not allow invalid vote_types" do
      expect { vote.vote_type = 'invalid' }.to raise_error(ArgumentError)
    end
  end

  describe "counter_culture" do
    it "increments vote_ups_count for up votes" do
      expect { vote.save }.to change { movie.reload.vote_ups_count }.by(1)
    end

    it "increments vote_downs_count for down votes" do
      vote.vote_type = 'down'
      expect { vote.save }.to change { movie.reload.vote_downs_count }.by(1)
    end
  end
end
