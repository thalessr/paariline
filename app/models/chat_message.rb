# frozen_string_literal: true

class ChatMessage < ApplicationRecord

  belongs_to :chat_room
  belongs_to :sent_by, class_name: 'User'
  belongs_to :seen_by, class_name: 'User', optional: true

end
