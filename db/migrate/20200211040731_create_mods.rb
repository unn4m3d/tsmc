class CreateMods < ActiveRecord::Migration[5.1]
  def change
    create_table :mods do |t|
      t.string :title
      t.string :wiki

      t.timestamps
    end
  end
end
