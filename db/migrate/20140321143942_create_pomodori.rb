class CreatePomodori < ActiveRecord::Migration
  def change
    create_table :pomodori do |t|

      t.timestamps
    end
  end
end
