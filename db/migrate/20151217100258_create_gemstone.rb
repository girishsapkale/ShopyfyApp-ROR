class CreateGemstone < ActiveRecord::Migration
  def change
    create_table :gemstones do |t|
      t.string :name
      #t.belongs_to :product, index: true, foreign_key: true
      #t.integer :price
    end
  end
end
