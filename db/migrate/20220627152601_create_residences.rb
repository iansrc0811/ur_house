class CreateResidences < ActiveRecord::Migration[7.0]
  def change
    create_table :residences do |t|
      t.string :title, null: false
      t.integer :price, null: false
      t.references :city, null: false, foreign_key: true
      t.references :district, null: false, foreign_key: true
      t.string :address, null: false
      t.integer :room_number, null: false
      t.string :mrt

      t.timestamps
    end
  end
end
