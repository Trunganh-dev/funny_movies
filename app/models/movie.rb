# frozen_string_literal: true

# == Schema Information
#
# Table name: movies
#
#  id               :bigint           not null, primary key
#  description      :text(65535)
#  thumb_url        :string(255)      not null
#  title            :string(255)      not null
#  vote_downs_count :bigint           default(0), not null
#  vote_ups_count   :bigint           default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#  video_id         :string(255)      not null
#
# Indexes
#
#  index_movies_on_video_id  (video_id) UNIQUE
#
class Movie < ApplicationRecord
  validates :title, :thumb_url, presence: true
  validates :video_id, presence: true, uniqueness: true

  belongs_to :user, inverse_of: :movies
  has_many :votes, dependent: :destroy, inverse_of: :movie

  def embed_url
    "https://www.youtube.com/embed/#{video_id}?autoplay=0&amp;cc_load_policy=1&amp;controls=2&amp;hl=vi&amp;rel=0&amp;enablejsapi=1&amp;widgetid=1"
  end

  def is_voted_by?(user_id)
    return false if user_id.blank?

    votes.find_by(user_id: user_id).present?
  end
end
