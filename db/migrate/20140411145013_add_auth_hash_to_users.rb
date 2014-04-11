class AddAuthHashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_hash, :string
  end
end
