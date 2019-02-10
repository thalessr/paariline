# frozen_string_literal: true

FactoryBot.define do
  factory :profile_picture do
    user
    dislike_count { Faker::Number.number(2) }
    like_count { Faker::Number.number(2) }
  end
end
