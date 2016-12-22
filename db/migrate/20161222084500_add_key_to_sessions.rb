class AddKeyToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :key, :string
  end
end
