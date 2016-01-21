class AddLatitudeAndLongitudeToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :latitude, :float
    add_column :plans, :longitude, :float
  end
end
