class AddLatitudeAndLongitudeToMemories < ActiveRecord::Migration
  def change
    add_column :memories, :latitude, :float
    add_column :memories, :longitude, :float
  end
end
