# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[5.2]

  def change
    create_table :activities do |t|
      t.belongs_to :owner, foreign_key: { to_table: :users }, index: true, null: false
      t.string :description, null: false
      t.string :source_name, null: false
      t.integer :source_id, null: false
      t.string :icon
      t.string :color
      t.timestamp :happened_at, null: false

      t.index :source_id
      t.index :source_name
      t.timestamps
    end
  end

end
