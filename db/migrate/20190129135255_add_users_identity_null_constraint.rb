class AddUsersIdentityNullConstraint < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:users, :identity_name, false)
  end
end
