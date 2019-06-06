class ChangeDataStatusUser < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :status, :integer, default: 1
  end
end
