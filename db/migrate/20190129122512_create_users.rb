class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :identity_name
      t.string :identity_sname

      t.timestamps
    end
  end
end
