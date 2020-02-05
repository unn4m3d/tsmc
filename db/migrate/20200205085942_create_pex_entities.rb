class CreatePexEntities < ActiveRecord::Migration[5.1]
  def change
    create_table :pex_entities do |t|
      t.string :name, limit: 50
      t.integer :type, limit: 1
      t.integer :default

      t.timestamps null: true
    end
  end
end
