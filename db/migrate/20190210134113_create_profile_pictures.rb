# frozen_string_literal: true

class CreateProfilePictures < ActiveRecord::Migration[5.2]

  def change
    create_table :profile_pictures do |t|
      t.belongs_to :user, foreign_key: true, null: false, index: true
      t.integer :dislike_count, default: 0
      t.integer :like_count, default: 0

      t.timestamps
    end
  end

end
