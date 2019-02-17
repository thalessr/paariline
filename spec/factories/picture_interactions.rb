# frozen_string_literal: true

FactoryBot.define do
  factory :picture_interaction do
    user
    profile_picture
    interaction_type { PictureInteraction::InteractionTypes::Like }
  end
end
