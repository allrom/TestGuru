class ChangeColumnNameBadgesTable < ActiveRecord::Migration[5.2]
  def change
    rename_column(:badges, :program, :title)
  end
end
