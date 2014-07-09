class AddTrelloTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :trello_token, :string
  end
end
