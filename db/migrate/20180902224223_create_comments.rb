class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :owner, index: true, foreign_key: {to_table: :users}
      t.references :card, foreign_key: true
      t.references :comment, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
