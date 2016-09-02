class Gemstone < ActiveRecord::Base
  #belongs_to :product

  def self.synchronization
    ShopifyAPI::Base.site = Shop.last.url

    @total_products = ShopifyAPI::Product.count
    @total_pages = (@total_products / 250.0).ceil

    products = []

    @total_pages.times do |x|
      page = x+1
      products += ShopifyAPI::Product.find(:all, :params => {:limit => 250, :page => page})
    end

    gemstone_list = []
    products.each do |p|
    if p.options.last.name == 'Gemstone'
      gemstone = p.options.last.values
        gemstone.each do |gemstone_title|
          gemstone_list << gemstone_title
        end           
      end
    end
    @gems = gemstone_list.uniq
    @gems.each do |gemstone|
      Gemstone.create(:name => gemstone)
    end  
 end  
end
