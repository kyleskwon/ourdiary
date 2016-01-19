class AddLabelToMemories < ActiveRecord::Migration
  def change
    add_column :memories, :label, :string
  end
end
