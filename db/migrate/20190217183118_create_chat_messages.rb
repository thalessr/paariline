# frozen_string_literal: true

class CreateChatMessages < ActiveRecord::Migration[5.2]

  def change
    create_table :chat_messages do |t|
      t.belongs_to :chat_room, foreign_key: true, index: true
      t.belongs_to :sent_by, foreign_key: { to_table: :users }, index: true
      t.belongs_to :seen_by, foreign_key: { to_table: :users }, index: true
      t.text :content
      t.timestamp :seent_at
      t.timestamp :sent_at
    end
  end

end
