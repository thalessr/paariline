# frozen_string_literal: true

class ChatRoomsController < ApplicationController

  before_action :authenticate_user!

  def index
    render json: ChatRoomSerializer.new(
      ChatRoom.user_rooms(current_user)
    ).serialized_json
  end

end
