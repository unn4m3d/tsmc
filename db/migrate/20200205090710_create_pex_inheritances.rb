class CreatePexInheritances < ActiveRecord::Migration[5.1]
  def change
    create_table :pex_inheritances do |t|
      t.string :child, limit: 50
      t.string :parent, limit: 50
      t.integer :type, limit: 1
      t.string :world, limit: 50

      t.timestamps null: true
    end
  end
end
