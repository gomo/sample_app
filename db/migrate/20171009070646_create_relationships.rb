class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships, {:id => false} do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.references :follower, index: true, foreign_key: { to_table: :users }
      t.references :followed, index: true, foreign_key: { to_table: :users }
    end
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
