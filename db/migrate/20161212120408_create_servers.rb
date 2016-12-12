class CreateServers < ActiveRecord::Migration[5.0]
  def change
    create_table :servers do |t|
      t.string :name
      t.string :short_name
      t.string :version
      t.stirng :ip
      t.int :port

      t.timestamps
    end
    add_index :servers, :short_name, unique: true
  end
end
