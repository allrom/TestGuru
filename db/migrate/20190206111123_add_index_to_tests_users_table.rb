class AddIndexToTestsUsersTable < ActiveRecord::Migration[5.2]
  def change
    add_index :tests_users, [:user_id, :test_id], unique: true
  end
end
