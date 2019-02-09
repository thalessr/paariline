# frozen_string_literal: true

RSpec.configure do |c|
  c.include Warden::Test::ControllerHelpers, type: :controller

  def sign_in(user)
    warden.set_user(user)
  end
end
