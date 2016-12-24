class AddAttachmentSkinToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :skin
    end
  end

  def self.down
    remove_attachment :users, :skin
  end
end
