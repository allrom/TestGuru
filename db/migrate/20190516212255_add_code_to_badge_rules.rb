class AddCodeToBadgeRules < ActiveRecord::Migration[5.2]
  def change
    add_column(:badge_rules, :code, :string)
    change_column_null(:badge_rules, :code, false)
  end
end
