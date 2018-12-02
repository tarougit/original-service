class CreateHexagons < ActiveRecord::Migration[5.0]
  def change
    create_table :hexagons do |t|
      t.integer :pass
      t.integer :dribble
      t.integer :shoot
      t.integer :body_control
      t.integer :judgement
      t.integer :speed

      t.timestamps
    end
  end
end
