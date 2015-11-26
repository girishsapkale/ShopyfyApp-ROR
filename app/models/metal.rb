class Metal < ActiveRecord::Base
  belongs_to :product
  validates :price, numericality: { only_integer: true }
end
