class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.references :owner, index: true, foreign_key: {to_table: :users}
      t.string :title, null: false

      t.timestamps
    end
  end
end
