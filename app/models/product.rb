class Product < ActiveRecord::Base
	has_many :metals, :dependent => :destroy
    has_many :variant_backups, :dependent => :destroy
	#has_many :gemstones, :dependent => :destroy

	accepts_nested_attributes_for :metals, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
	#accepts_nested_attributes_for :gemstones, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

    def self.get_all_metal_products
      ShopifyAPI::Base.site = Shop.last.url

      @total_products = ShopifyAPI::Product.count
      @total_pages = (@total_products / 250.0).ceil

      @products = []
      @total_pages.times do |x|
        page = x+1
        @products += ShopifyAPI::Product.find(:all, :params => {:limit => 250, :page => page})
      end
      
      @products.each do |product|
        if product.options.first.name == 'Metal'
          element = Product.new
          element.title = product.title
          element.product_type = product.product_type
          element.prod_id = product.id
          product.options.first.values.each do |title|
              element.metals.build(:name => title.downcase ,:price => 0)
          end 
          # if product.options.last.name == 'Gemstone'
          #   product.options.last.values.each do |title|
          #     element.gemstones.build(:name => title ,:price => 0)
          #   end 
          # end
          # product.variants.each do |var|
          #  element.metals.build(:name => var.option1, :gemstone => var.option2, :price => 0)
          # end      
          element.save!           
        end      
      end

      # webhooks = ShopifyAPI::Webhook.all
      # webhooks.each do |x|
      #   x.destroy
      # end
      # update_webhook = ShopifyAPI::Webhook.new({:topic => "products/update", :address => "http://rorapp.mobikasa.com/webhooks/update_product", :format => "json"})
      # update_webhook.save!
      # create_webhook = ShopifyAPI::Webhook.new({:topic => "products/create", :address => "http://rorapp.mobikasa.com/webhooks/create_product", :format => "json"})
      # create_webhook.save!
    end
end
