class CreateFavoriteLists < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :residence, null: false, foreign_key: true

      t.timestamps
    end
  end
end
