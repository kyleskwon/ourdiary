class CreateMemories < ActiveRecord::Migration
  def change
    create_table :memories do |t|
      t.string :title
      t.text :caption
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
