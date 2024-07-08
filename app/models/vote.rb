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
class Vote < ApplicationRecord
  belongs_to :movie, inverse_of: :votes
  belongs_to :user, inverse_of: :votes

  counter_culture :movie, column_name: proc { |model| model.up? ? 'vote_ups_count' : 'vote_downs_count' }

  enum vote_type: { "up" => 0, "down" => 1 }

  validates :movie_id, uniqueness: { scope: :user_id, message: :taken }
end
