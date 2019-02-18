# frozen_string_literal: true

class PictureInteraction < ApplicationRecord

  module InteractionTypes
    LIKE = 'like'
    DISLIKE = 'dislike'
    ALL = constants(false).collect { |const| const_get(const) }
  end

  belongs_to :user
  belongs_to :profile_picture

  scope :recently_viewed, -> { where('created_at >= ?', 6.hours.ago) }

  validates :interaction_type, inclusion: { in: InteractionTypes::ALL }, presence: true

  after_commit :update_like_counter, if: proc { |record| record.interaction_type == InteractionTypes::LIKE }
  after_commit :update_dislike_counter, if: proc { |record| record.interaction_type == InteractionTypes::DISLIKE }
  after_commit :create_chat_room_if_matched, if: proc { |record| record.interaction_type == InteractionTypes::LIKE }

  delegate :user_id, to: :profile_picture, prefix: true

  class << self

    def likes
      where(interaction_type: InteractionTypes::LIKE)
    end

    def dislikes
      where(interaction_type: InteractionTypes::DISLIKE)
    end

    def liked_by(user_id:, profile_picture_user_id:)
      joins(:profile_picture).likes.where(user_id: user_id, profile_pictures: { user_id: profile_picture_user_id })
    end

  end

  private

  def update_like_counter
    counter = PictureInteraction.joins(:profile_picture).likes.where(
      profile_pictures: { user_id: profile_picture_user_id }
    ).count
    profile_picture.update(like_count: counter)
  end

  def update_dislike_counter
    counter = PictureInteraction.joins(:profile_picture).dislikes.where(
      profile_pictures: { user_id: profile_picture_user_id }
    ).count
    profile_picture.update(like_count: counter)
  end

  def create_chat_room_if_matched
    return if ChatRoom.user_rooms(user_id).user_rooms(profile_picture_user_id).any?

    user_liked = PictureInteraction.liked_by(user_id: user_id, profile_picture_user_id: profile_picture_user_id).any?
    profile_picture_user_liked = PictureInteraction.liked_by(
      user_id: profile_picture_user_id, profile_picture_user_id: user_id
    ).any?

    return unless user_liked && profile_picture_user_liked

    ChatRoom.create!(participant_id: user_id, created_by_id: profile_picture_user_id)
  end

end
