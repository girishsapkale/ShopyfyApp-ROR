class Metal < ActiveRecord::Base
  belongs_to :product
  validates :price, numericality: { only_integer: true }
  after_save :status_update

  def status_update
  	total = product.metals.count
  	filled = product.metals.where('price > ?', 0).count
  	unfilled = product.metals.where('price = ?', 0).count  
		if filled === total
  		product.update_attributes(:status => "all_filled")
		elsif filled < total && filled > 0
  		product.update_attributes(:status => "partially_filled")
		else
 			product.update_attributes(:status => "depopulated")
		end
	end
end
