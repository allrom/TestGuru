class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :program
      t.string :image_filename

       t.timestamps
    end
  end
end
