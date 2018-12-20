class CreateHexagons < ActiveRecord::Migration[5.0]
  def change
    create_table :hexagons do |t|
      t.string :name

      t.timestamps
    end
  end
end
