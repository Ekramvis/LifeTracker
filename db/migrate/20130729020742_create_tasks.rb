class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.string :frequency
      t.integer :value
      t.integer :cap
      t.integer :goal_id

      t.timestamps
    end

    add_index :tasks, :goal_id
  end
end
