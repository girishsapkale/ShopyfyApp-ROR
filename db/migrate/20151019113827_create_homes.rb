class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :shop_url

      t.timestamps null: false
    end
  end
end
