# frozen_string_literal: true

class ProfilePicturesController < ApplicationController

  def index
    render json: ProfilePicturesSerializer.new(
      ProfilePicture.includes(:user).with_attached_picture.take(3)
    ).serialized_json
  end

  def like
    @profile_picture = ProfilePicture.find(params[:id])
    @profile_picture.add_like(current_user)
    if @profile_picture.save
      render json: ProfilePicturesSerializer.new(@profile_picture).serialized_json, status: :created
    else
      render json: { errors: @profile_picture.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def dislike
    @profile_picture = ProfilePicture.find(params[:id])
    @profile_picture.add_dislike(current_user)
    if @profile_picture.save
      render json: ProfilePicturesSerializer.new(@profile_picture).serialized_json, status: :created
    else
      render json: { errors: @profile_picture.errors.full_messages }, status: :unprocessable_entity
    end
  end

end
