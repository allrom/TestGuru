class CreateBadgeGears < ActiveRecord::Migration[5.2]
  def change
    create_table :badge_gears do |t|
      t.references :user, foreign_key: true
      t.references :badge, foreign_key: true

       t.integer :badge_count, default: 0

      t.timestamps
    end
  end
end
