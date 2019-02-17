# frozen_string_literal: true

class UsersController < ApplicationController

  def show
    render json: current_user_json, status: :ok
  end

  def update
    if current_user.update(user_params)
      render json: current_user_json, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :age, :email, :city, :birth_date
    )
  end

  def current_user_json
    UserSerializer.new(current_user).serialized_json
  end

end
