# frozen_string_literal: true

class ProfilePicturesController < ApplicationController

  def index
    render json: ProfilePicturesSerializer.new(
      ProfilePicture.includes(:user).with_attached_picture.avaiable_to_display(current_user)
    ).serialized_json
  end

  def like
    @profile_picture = ProfilePicture.find(params[:id])
    @profile_picture.add_like(current_user)
    if @profile_picture.save
      render json: @profile_picture, status: :created
    else
      render json: { errors: @profile_picture.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def dislike
    @profile_picture = ProfilePicture.find(params[:id])
    @profile_picture.add_dislike(current_user)
    if @profile_picture.save
      render json: @profile_picture, status: :created
    else
      render json: { errors: @profile_picture.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def most_rated
    render json: ProfilePicturesSerializer.new(
      ProfilePicture.includes(:user).with_attached_picture.most_rated(current_user)
    ).serialized_json
  end

end
