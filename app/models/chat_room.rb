# frozen_string_literal: true

class ChatRoom < ApplicationRecord

  belongs_to :participant, class_name: 'User'
  belongs_to :created_by, class_name: 'User'

  before_validation :add_chat_name, on: :create

  validates :participant_id, uniqueness: { scope: :created_by_id }

  def add_chat_name
    self.name = "chat_room_#{participant_id}_#{created_by_id}"
  end

end
