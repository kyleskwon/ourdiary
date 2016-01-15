class CreateHomebases < ActiveRecord::Migration
  def change
    create_table :homebases do |t|

      t.timestamps null: false
    end
  end
end
