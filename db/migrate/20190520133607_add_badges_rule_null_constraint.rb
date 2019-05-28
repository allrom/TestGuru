class AddBadgesRuleNullConstraint < ActiveRecord::Migration[5.2]
  def change
     change_column_null(:badges, :rule_id, false)
  end
end
