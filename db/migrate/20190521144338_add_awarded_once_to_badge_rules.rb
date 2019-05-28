class AddAwardedOnceToBadgeRules < ActiveRecord::Migration[5.2]
  def change
    add_column(:badge_rules, :awarded_once, :boolean, null: false, default: true)
    add_index(:badge_rules, :awarded_once, where: "awarded_once is true")
  end
end
