# frozen_string_literal: true

class ActivitiesController < ApplicationController

  def index
    activities = current_user.activities.order(created_at: :desc)
    render json: ActivitySerializer.new(activities).serialized_json
  end

end
