class CreateServerStats < ActiveRecord::Migration[5.0]
  def change
    create_table :server_stats do |t|
      t.belongs_to :server, foreign_key: true
      t.boolean :online
      t.integer :players
      t.datetime :time

      t.timestamps
    end
  end
end
