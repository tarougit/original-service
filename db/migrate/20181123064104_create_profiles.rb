class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :icon
      t.string :active_area
      t.string :sex
      t.date :birthday
      t.string :sports
      t.string :level
      t.string :level_maximum
      t.text :battle_record
      t.text :career

      t.timestamps
    end
  end
end
