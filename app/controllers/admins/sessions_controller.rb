# frozen_string_literal: true

module Admins
  class SessionsController < Devise::SessionsController

    include Accessible
    skip_before_action :check_user, only: :destroy # rubocop:disable LexicallyScopedActionFilter

  end
end
