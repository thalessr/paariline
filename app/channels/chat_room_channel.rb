# frozen_string_literal: true

class ChatRoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from specific_channel
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def communicate; end

  private

  def specific_channel
    "#{channel_name}_#{params['room'] || 'main'}"
  end

end
