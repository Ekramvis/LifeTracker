class AddCompletedTable < ActiveRecord::Migration
  def change
    create_table :completions do |t|
      t.integer :task_id

      t.timestamps
    end
  end
end
