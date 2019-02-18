# frozen_string_literal: true

class ChatRoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from specific_channel
  end

  def unsubscribed
    stop_all_streams
  end

  def receive(data)
    data.symbolize_keys!
    chat_room = ChatRoom.find_by!(name: params['room'])
    chat_message = ChatMessage.create!(
      chat_room: chat_room, sent_by: current_user, sent_at: Time.zone.now, content: data[:content]
    )

    ActionCable.server.broadcast(
      specific_channel, ChatMessageSerializer.new(chat_message).serialized_json
    )
  end

  private

  def specific_channel
    "#{channel_name}_#{params['room'] || current_user.id}"
  end

end
