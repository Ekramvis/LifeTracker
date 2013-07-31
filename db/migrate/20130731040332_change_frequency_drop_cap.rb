class ChangeFrequencyDropCap < ActiveRecord::Migration
  def change
    remove_column :tasks, :cap
    remove_column :tasks, :frequency
    add_column :tasks, :frequency, :integer
  end
end
