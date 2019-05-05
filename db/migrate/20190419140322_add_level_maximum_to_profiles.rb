class AddLevelMaximumToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :level_maximum, :string
  end
end
