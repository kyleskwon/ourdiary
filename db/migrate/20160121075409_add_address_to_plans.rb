class AddAddressToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :address, :string
  end
end
