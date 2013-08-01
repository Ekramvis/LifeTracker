class AddCompletedDateToCompletion < ActiveRecord::Migration
  def change
    add_column :completions, :date_completed, :date
  end
end
