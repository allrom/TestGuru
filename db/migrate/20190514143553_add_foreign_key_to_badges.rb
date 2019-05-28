class AddForeignKeyToBadges < ActiveRecord::Migration[5.2]
  def change
    add_column(:badges, :rule_id, :integer)
    add_foreign_key(:badges, :badge_rules, column: :rule_id)

    change_column_null(:badges, :program, false)
    change_column_null(:badges, :image_filename, false)
  end
end
