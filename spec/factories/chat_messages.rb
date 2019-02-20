# frozen_string_literal: true

FactoryBot.define do
  factory :chat_message do
    association :sent_by, factory: :user
    association :seen_by, factory: :user
    chat_room
    sent_at { Time.zone.now }
    seent_at { Time.zone.now }
    content { Faker::HitchhikersGuideToTheGalaxy.quote }
  end
end
