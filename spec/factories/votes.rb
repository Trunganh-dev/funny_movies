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
FactoryBot.define do
  factory :vote do
    vote_type { 'up' }
    association :user
    association :movie
  end
end
