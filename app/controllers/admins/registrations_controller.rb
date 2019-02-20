# frozen_string_literal: true

module Admins
  class RegistrationsController < Devise::RegistrationsController

    include Accessible

    skip_before_action :check_user, except: %i[new create] # rubocop:disable LexicallyScopedActionFilter

  end
end
