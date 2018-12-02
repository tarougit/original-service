class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :icon
      t.integer :pass
      t.integer :dribble
      t.integer :shoot
      t.integer :body_control
      t.integer :judgement
      t.integer :speed
      t.string :active_area
      t.string :sex
      t.date :birthday
      t.string :sports
      t.string :level
      t.text :battle_record
      t.text :career

      t.timestamps
    end
  end
end
