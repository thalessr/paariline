# frozen_string_literal: true

FactoryBot.define do
  factory :activity do
    happened_at { Time.zone.now }
    description { Faker::GreekPhilosophers.quote }
    source_name { 'User' }
    source_id { owner&.id }
    icon { 'settings' }
    color { Faker::Color.hex_color }
    association :owner, factory: :user
  end
end
