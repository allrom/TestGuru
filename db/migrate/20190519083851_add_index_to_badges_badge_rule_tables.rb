class AddIndexToBadgesBadgeRuleTables < ActiveRecord::Migration[5.2]
  def change
    add_index :badges, :rule_id, unique: true
    add_index :badge_rules, :code
  end
end
