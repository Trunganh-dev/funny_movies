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
FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    description { Faker::Lorem.paragraph }
    thumb_url { Faker::Internet.url }
    sequence(:video_id) { |n| "video_#{n}" }
    user
  end
end
