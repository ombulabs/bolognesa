class CreatePomodoriTags < ActiveRecord::Migration
  def change
    create_table :pomodori_tags do |t|
      t.belongs_to :tag
      t.belongs_to :pomodori
      t.timestamps
    end
  end
end
