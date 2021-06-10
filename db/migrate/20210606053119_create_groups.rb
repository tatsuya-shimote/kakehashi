class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.references :user, foreign_key: true
      t.integer :limit
      t.text :content
      t.string :learning

      t.timestamps
    end
  end
end
