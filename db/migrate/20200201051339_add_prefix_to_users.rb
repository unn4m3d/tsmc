class AddPrefixToUsers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :users do |t|
      t.string :prefix
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :prefix
    end
  end
end
