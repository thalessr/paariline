# frozen_string_literal: true

class ChatMessageSerializer

  include FastJsonapi::ObjectSerializer
  attributes :content, :sent_by_full_name

  attributes :sent_at, &:created_at

end
