class Variant < ActiveRecord::Base
	validates :metal_title, uniqueness: true
end
