class VariantBackup < ActiveRecord::Base
 belongs_to :product
 # t.string :sku
 # t.string :title
 # t.string :status, default: 'original'       
 # t.integer :product_id #rorapp product id      
 # t.string :store_variant_id
 # t.string :store_product_id
 # t.integer :position, default: 0
 # t.integer :initial_price, default: 0
 # t.integer :current_price
 # t.text :updated_prices

end
