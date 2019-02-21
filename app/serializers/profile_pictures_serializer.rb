# frozen_string_literal: true

class ProfilePicturesSerializer

  include FastJsonapi::ObjectSerializer
  attributes :dislike_count, :like_count, :user_full_name, :user_city, :user_age

  attribute :picture_url do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object.picture, only_path: true) if object.picture.attached?
  end

end
