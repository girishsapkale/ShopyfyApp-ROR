class Shop < ActiveRecord::Migration
  def change
  	 create_table :shops do |t|
      t.string :url,              null: false, default: ""
      
      t.timestamps null: false
    end
  end
end
