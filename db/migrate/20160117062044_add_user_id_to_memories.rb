class AddUserIdToMemories < ActiveRecord::Migration
  def change
    add_column :memories, :user_id, :integer
  end
end
