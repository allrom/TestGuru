class AddRuleValueColumnToBadgeRules < ActiveRecord::Migration[5.2]
  def change
    add_column(:badge_rules, :value, :string)
  end
end
