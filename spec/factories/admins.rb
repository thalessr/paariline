# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    password { Faker::Number.number(10) }
    password_confirmation { password }
  end
end
