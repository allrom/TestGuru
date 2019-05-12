class AddIndexesToTables < ActiveRecord::Migration[5.2]
  def change
    add_index :answers, :question_id
  #  add_index :gists, :question_id
    add_index :questions, :test_id
    add_index :tests, :category_id
  end
end
