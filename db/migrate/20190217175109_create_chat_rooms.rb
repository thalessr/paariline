# frozen_string_literal: true

class CreateChatRooms < ActiveRecord::Migration[5.2]

  def change
    create_table :chat_rooms do |t|
      t.belongs_to :participant, foreign_key: { to_table: :users }, index: true, null: false
      t.belongs_to :created_by, foreign_key: { to_table: :users }, index: true, null: false
      t.string :name, null: false

      t.index %i[participant_id created_by_id], unique: true
      t.timestamps
    end
  end

end
