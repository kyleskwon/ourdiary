class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :title
      t.text :caption

      t.timestamps null: false
    end
  end
end
