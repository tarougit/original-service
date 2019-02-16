class RemoveStatusFromPost < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :status, :integer
  end
end
