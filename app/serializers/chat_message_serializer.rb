# frozen_string_literal: true

class ChatMessageSerializer

  include FastJsonapi::ObjectSerializer
  attributes :content, :sent_at

end
