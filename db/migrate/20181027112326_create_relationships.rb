class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
      
      t.index [:user_id, :post_id], unique: true
    end
  end
end
