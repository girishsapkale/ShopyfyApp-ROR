class AddStatusToProducts < ActiveRecord::Migration
  def change
    add_column :products, :status, :string, :default => "unfilled"
  end
end
