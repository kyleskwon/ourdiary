class AddAttachmentAvatarToMemories < ActiveRecord::Migration
  def self.up
    change_table :memories do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :memories, :avatar
  end
end
