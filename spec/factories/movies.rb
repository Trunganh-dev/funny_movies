# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    description { Faker::Lorem.paragraph }
    thumb_url { Faker::Internet.url }
    sequence(:video_id) { |n| "video_#{n}" }
    user
  end
end
