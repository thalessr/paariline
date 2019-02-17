# frozen_string_literal: true

class PictureInteraction < ApplicationRecord

  module InteractionTypes
    LIKE = 'like'
    DISLIKE = 'dislike'
    ALL = constants(false).collect { |const| const_get(const) }
  end

  belongs_to :user
  belongs_to :profile_picture

  validates :interaction_type, inclusion: { in: InteractionTypes::ALL }, presence: true

  after_commit :update_like_counter, if: proc { |record| record.interaction_type == InteractionTypes::LIKE }
  after_commit :update_dislike_counter, if: proc { |record| record.interaction_type == InteractionTypes::DISLIKE }

  class << self

    def likes
      where(interaction_type: InteractionTypes::LIKE)
    end

    def dislikes
      where(interaction_type: InteractionTypes::DISLIKE)
    end

  end

  def update_like_counter
    profile_picture.update(like_count: PictureInteraction.likes.count)
  end

  def update_dislike_counter
    profile_picture.update(like_count: PictureInteraction.dislikes.count)
  end

end
