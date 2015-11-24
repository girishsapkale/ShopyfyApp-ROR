class Product < ActiveRecord::Base
	has_many :metals, :dependent => :destroy
	accepts_nested_attributes_for :metals, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
end
