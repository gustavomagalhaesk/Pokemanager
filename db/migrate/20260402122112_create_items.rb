class CreateItems < ActiveRecord::Migration[8.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :sku
      t.integer :quantity
      t.decimal :price
      t.string :url_image

      t.timestamps
    end
  end
end
