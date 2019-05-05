class ChangeColumnToPost < ActiveRecord::Migration[5.0]
  def change
    change_column :posts, :reserve, :integer, default: 0
  end
end
