class Product < ActiveRecord::Base
	has_many :metals, :dependent => :destroy
	#has_many :gemstones, :dependent => :destroy

	accepts_nested_attributes_for :metals, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
	#accepts_nested_attributes_for :gemstones, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

end
