class AddImageToResidence < ActiveRecord::Migration[7.0]
  def change
    add_column :residences, :image, :string
  end
end
