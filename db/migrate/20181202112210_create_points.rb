class CreatePoints < ActiveRecord::Migration[5.0]
  def change
    create_table :points do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.references :evaluated_user, foreign_key: { to_table: :users }
      t.references :hexagon, foreign_key: true

      t.timestamps
    end
  end
end
