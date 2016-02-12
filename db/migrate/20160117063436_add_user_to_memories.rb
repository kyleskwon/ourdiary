class AddUserToMemories < ActiveRecord::Migration
  def change
    add_index :memories, :user_id
  end
end
