class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.string :message

      t.timestamps
      t.index [:user_id, :group_id]
    end
  end
end
