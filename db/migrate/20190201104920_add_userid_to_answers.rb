class AddUseridToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column(:answers, :user_id, :integer)
    change_column_null(:answers, :user_id, false)
    add_foreign_key(:answers, :users)
  end
end
