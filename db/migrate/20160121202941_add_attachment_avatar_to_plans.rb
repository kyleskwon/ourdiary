class AddAttachmentAvatarToPlans < ActiveRecord::Migration
  def self.up
    change_table :plans do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :plans, :avatar
  end
end
