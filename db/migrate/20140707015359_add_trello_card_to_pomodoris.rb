class AddTrelloCardToPomodoris < ActiveRecord::Migration
  def change
    add_column :pomodoris, :card_name, :string
  end
end
