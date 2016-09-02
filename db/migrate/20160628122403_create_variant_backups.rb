class CreateVariantBackups < ActiveRecord::Migration
  def change
    create_table :variant_backups do |t|      
      t.string :sku
      t.string :title
      t.string :status, default: 'original'       
      t.integer :product_id #rorapp product id      
      t.string :store_variant_id
      t.string :store_product_id
      t.integer :position, default: 0
      t.string :initial_price
      t.string :current_price
      t.text :updated_prices

      t.timestamps null: false
    end
  end
end
