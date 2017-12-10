class FixHousesColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :houses, :photo, :house_profile_pic
  end
end
