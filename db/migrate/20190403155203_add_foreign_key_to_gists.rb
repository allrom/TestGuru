class AddForeignKeyToGists < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key(:gists, :users)
  end
end
