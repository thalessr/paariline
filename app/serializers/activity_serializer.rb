# frozen_string_literal: true

class ActivitySerializer

  include FastJsonapi::ObjectSerializer
  attributes :happened_at, :description

end
