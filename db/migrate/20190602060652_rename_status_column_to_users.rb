class RenameStatusColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :status, :state
  end
end
