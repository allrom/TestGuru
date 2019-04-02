class CreateGists < ActiveRecord::Migration[5.2]
  def change
    create_table :gists do |t|
			t.belongs_to :question, index: true
      t.string :url
      t.string :email

      t.timestamps
    end
  end
end
