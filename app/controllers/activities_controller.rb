# frozen_string_literal: true

class ActivitiesController < ApplicationController

  def index
    activities = Activity.where(owner: current_user).order(created_at: :desc)
    render json: ActivitySerializer.new(activities).serialized_json
  end

end
