# frozen_string_literal: true

class ChatRoomsController < ApplicationController

  def index
    render json: ChatRoom.user_rooms(current_user.id)
  end

end
