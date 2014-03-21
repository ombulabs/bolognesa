class CreatePomodoris < ActiveRecord::Migration
  def change
    create_table :pomodoris do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
