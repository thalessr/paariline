# frozen_string_literal: true

class ChatMessagesController < ApplicationController

  before_action :authenticate_user!

  def index
    render json: ChatMessageSerializer.new(
      ChatMessage.includes(:sent_by).joins(:chat_room).where(chat_rooms: { name: params[:room_name] })
    ).serialized_json
  end

end
