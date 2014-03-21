class AddUserIdToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :user_id, :integer
  end
end
