class CreateHouses < ActiveRecord::Migration[5.1]
  def change
    create_table :houses do |t|
      t.belongs_to :user, index: true
      t.string  :name
      t.string  :street, null: false
      t.string  :city, null: false
      t.string  :state, null: false
      t.string  :zip_code, null: false
      t.integer :asking_amount
      t.integer :total_sqft
      t.string  :photo

      t.timestamps
    end
  end
end
