class CreatePexPermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :pex_permissions do |t|
      t.string :name, limit: 50
      t.integer :type, limit: 1
      t.text :permission
      t.string :world, limit: 50
      t.text :value

      t.timestamps null: true
    end
  end
end
