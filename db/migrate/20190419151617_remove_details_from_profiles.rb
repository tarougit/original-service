class RemoveDetailsFromProfiles < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :pass, :integer
    remove_column :profiles, :dribble, :integer
    remove_column :profiles, :shoot, :integer
    remove_column :profiles, :body_control, :integer
    remove_column :profiles, :judgement, :integer
    remove_column :profiles, :speed, :integer
  end
end
