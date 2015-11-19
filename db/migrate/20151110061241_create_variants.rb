class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.string :metal_title,              null: false, default: ""
      t.string :metal_price
               

      t.timestamps null: false
    end
     add_index :variants, :metal_title,                unique: true
  end
end
