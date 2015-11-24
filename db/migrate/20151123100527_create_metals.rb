class CreateMetals < ActiveRecord::Migration
  def change
    create_table :metals do |t|
      t.string :name
      t.string :gemstone
      t.integer :price
      t.belongs_to :product, foreign_key: true

      t.timestamps null: false
    end
  end
end
