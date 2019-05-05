class RemoveImageFromProfiles < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :image, :string
  end
end
