class AddBoardsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :boards, :text
  end
end
