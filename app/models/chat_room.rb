# frozen_string_literal: true

class ChatRoom < ApplicationRecord

  belongs_to :participant, class_name: 'User'
  belongs_to :created_by, class_name: 'User'

  has_many :chat_messages, dependent: :restrict_with_error, inverse_of: :chat_room

  scope :user_rooms, ->(user_id) { ChatRoom.where(created_by_id: user_id).or(ChatRoom.where(participant_id: user_id)) }

  before_validation :add_chat_name, on: :create

  validates :participant_id, uniqueness: { scope: :created_by_id }

  delegate :full_name, to: :created_by, prefix: true
  delegate :full_name, to: :participant, prefix: true

  def add_chat_name
    self.name = "chat_room_#{participant_id}_#{created_by_id}"
  end

end
