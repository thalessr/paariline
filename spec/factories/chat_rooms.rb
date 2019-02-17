# frozen_string_literal: true

FactoryBot.define do
  factory :chat_room do
    name { Faker::App.name }
    association :participant, factory: :user
    association :created_by, factory: :user
  end
end
