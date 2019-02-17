# frozen_string_literal: true

class UserSerializer

  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :age, :email, :city, :id

  attribute :birth_date do |object|
    object.birth_date&.in_time_zone&.utc
  end

end
