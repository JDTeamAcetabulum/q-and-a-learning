class AddIndexToUsersUsername < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :password, unique: true
  end
end
