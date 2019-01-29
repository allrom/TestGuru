class AddUsersIdentityNullConstraint < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:users, :identity, false)
  end
end
