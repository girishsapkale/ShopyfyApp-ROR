class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|

      t.timestamps null: false
    end
  end
end
