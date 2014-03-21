class AddFinishedAtToPomodoris < ActiveRecord::Migration
  def change
    add_column :pomodoris, :finished_at, :datetime
  end
end
