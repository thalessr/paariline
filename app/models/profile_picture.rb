# frozen_string_literal: true

class ProfilePicture < ApplicationRecord

  belongs_to :user

  has_one_attached :picture

  has_many :picture_interactions, dependent: :restrict_with_error, inverse_of: :profile_picture

  has_many :like_interactions,
           -> { likes },
           class_name: 'PictureInteraction',
           dependent: :restrict_with_error,
           foreign_key: :profile_picture_id,
           inverse_of: :profile_picture

  has_many :dislike_interactions,
           -> { dislikes },
           class_name: 'PictureInteraction',
           dependent: :restrict_with_error,
           foreign_key: :profile_picture_id,
           inverse_of: :profile_picture

  scope :most_rated, ->(user_id) { where.not(user_id: user_id).order(like_count: :desc).take(20) }
  scope :avaiable_to_display, lambda { |user_id|
    left_joins(:picture_interactions).where.not(
      id: PictureInteraction.recently_viewed.pluck(:profile_picture_id),
      user_id: user_id
    )
  }

  delegate :full_name, :city, :age, to: :user, prefix: true

  def add_like(current_user)
    picture_interactions.build(
      user: current_user, interaction_type: PictureInteraction::InteractionTypes::LIKE
    )
    self
  end

  def add_dislike(current_user)
    picture_interactions.build(
      user: current_user, interaction_type: PictureInteraction::InteractionTypes::DISLIKE
    )
    self
  end

end
