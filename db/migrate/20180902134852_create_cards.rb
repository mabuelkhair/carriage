class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references :owner, index: true, foreign_key: {to_table: :users}
      t.references :list, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
