class AddCardsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cards, :text
  end
end
