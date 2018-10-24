class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :sports
      t.string :title
      t.text :content
      t.date :event_date
      t.time :open
      t.time :closed
      t.date :due_date
      t.time :due_time
      t.string :erea
      t.string :place
      t.integer :capacity
      t.integer :cost
      t.string :level
      t.integer :age_minimum
      t.integer :age_maximum
      t.string :sex

      t.timestamps
    end
  end
end
