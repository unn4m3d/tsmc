class AddDescriptionToServers < ActiveRecord::Migration[5.1]
  def change
    change_table :servers do |t|
      t.text :description
    end
  end
end
