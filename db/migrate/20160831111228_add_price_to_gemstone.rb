class AddPriceToGemstone < ActiveRecord::Migration
  def change
  	add_column :gemstones, :price, :integer, default: 0
  	add_column :products, :flag, :boolean, default: 0
  end
end
