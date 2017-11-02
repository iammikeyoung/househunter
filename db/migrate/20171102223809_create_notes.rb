class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.belongs_to :house, index: true
      t.belongs_to :user, index: true
      t.string :room, null: false
      t.integer :rating, default: 0
      t.text :pros
      t.text :cons


      t.timestamps
    end
  end
end
