class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :objective
      t.integer :user_id

      t.timestamps
    end

    add_index :goals, :user_id
  end
end
