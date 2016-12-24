class AddAttachmentCapeToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :cape
    end
  end

  def self.down
    remove_attachment :users, :cape
  end
end
