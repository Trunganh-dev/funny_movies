# frozen_string_literal: true

FactoryBot.define do
  factory :vote do
    vote_type { 'up' }
    association :user
    association :movie
  end
end
