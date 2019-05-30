class RemoveColumnsTests < ActiveRecord::Migration[5.2]
  def change
    remove_column(:tests, :timing)
    remove_column(:tests, :lasting)

    add_column(:tests, :expire_in, :integer)
  end
end
