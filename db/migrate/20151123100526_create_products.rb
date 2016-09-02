class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :prod_id
      t.string :product_type
      t.boolean :flag, default: 0

      t.timestamps null: false
    end
  end
end
