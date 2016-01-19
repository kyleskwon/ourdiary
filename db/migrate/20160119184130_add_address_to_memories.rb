class AddAddressToMemories < ActiveRecord::Migration
  def change
    add_column :memories, :address, :string
  end
end
