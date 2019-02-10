# frozen_string_literal: true

class AddFieldToUsers < ActiveRecord::Migration[5.2]

  def change
    add_column :users, :age, :integer
    add_column :users, :birth_date, :date
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :city, :string
  end

end
