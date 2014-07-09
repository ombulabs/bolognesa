class AddCurrentBoardToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_board, :string
  end
end
