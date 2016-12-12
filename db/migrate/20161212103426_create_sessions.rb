class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.references :user, foreign_key: true
      t.string :session
      t.string :serverid
      t.string :uuid

      t.timestamps
    end
  end
end
