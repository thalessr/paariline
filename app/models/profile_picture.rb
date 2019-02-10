# frozen_string_literal: true

class ProfilePicture < ApplicationRecord

  belongs_to :user

  has_one_attached :picture

end
