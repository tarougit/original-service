class AddReserveToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :reserve, :integer
  end
end
