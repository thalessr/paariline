# frozen_string_literal: true

class ChatMessageSerializer

  include FastJsonapi::ObjectSerializer
  attributes :content, :sent_at, :sent_by_full_name

end
