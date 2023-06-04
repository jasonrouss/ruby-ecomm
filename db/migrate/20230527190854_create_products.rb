class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.string :image
      t.string :condition
      t.string :size
      t.string :color
      t.string :category

      t.timestamps
    end
  end
end
