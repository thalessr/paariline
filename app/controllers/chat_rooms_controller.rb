# frozen_string_literal: true

class ChatRoomsController < ApplicationController

  def index
    render json: ChatRoomSerializer.new(
      ChatRoom.user_rooms(current_user)
    ).serialized_json
  end

end
