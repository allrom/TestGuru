class AddTimingToTests < ActiveRecord::Migration[5.2]
  def change
     add_column(:tests, :timing, :boolean, default: false)
     add_column(:tests, :lasting, :datetime, default: '1970-01-01 00:00:00')
  end
end
