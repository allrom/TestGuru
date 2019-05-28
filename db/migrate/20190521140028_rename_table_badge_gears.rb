class RenameTableBadgeGears < ActiveRecord::Migration[5.2]
  def change
    rename_table  :badge_gears,  :badges_users
  end
end
