# frozen_string_literal: true

class CreatePictureInteractions < ActiveRecord::Migration[5.2]

  def change
    create_table :picture_interactions do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :profile_picture, foreign_key: true, index: true
      t.string :interaction_type, null: false

      t.index :interaction_type
      t.timestamps
    end
  end

end
