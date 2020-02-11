class AddModsToServers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :servers, :mods do |t|
      t.index [:server_id, :mod_id]
    end
  end
end
