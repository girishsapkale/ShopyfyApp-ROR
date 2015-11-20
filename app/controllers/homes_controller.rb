class HomesController < ApplicationController
  
  def index
    @total_products = ShopifyAPI::Product.count
    @total_pages = (@total_products / 250.0).ceil
    @products = []
    @total_pages.times do |x|
      page = x+1
      @products += ShopifyAPI::Product.find(:all, :params => {:limit => 250, :page => page})
    end
    variants = Variant.all
    metals_list = []
    @products.each do |product|
      if product.options.first.name == 'Metal'
          metals = product.options.first.values
          metals.each do |metal_title|
          metals_list << metal_title.downcase
          end           
      end
    end
    @metals = metals_list.uniq
    if variants.blank?
        @metals.each do |metal_title|
           Variant.create(:metal_title => metal_title)
        end
    end
    @a=Variant.pluck(:metal_title)
    unless @metals & @a == @metals
      old_metal = @a - @metals
      if old_metal.present?
        Variant.find_by_metal_title(old_metal.first).destroy
      end
      new_metal = @metals - @a
      if new_metal.present?
        Variant.create(:metal_title => new_metal.first) 
      end
    end
    @variants = Variant.all
  end

  def update_metals
    count = params[:ids].count
    count.times do |x|
      @metal = Variant.find(params[:ids][x])
      @metal.update_attributes(:metal_price => params[:metal_prices][x])
    end
    redirect_to root_path, notice: 'Metal updated.' 
  end
  
  def diamond_values
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
          gemstone_list << gemstone_title.downcase
          end           
      end
    end
    @gemstones = gemstone_list.uniq

  end

  def update_variants_value
    if request.put? 
      params_variant = params[:gemstone].first.downcase
      params_new_price = params[:price]
      if( !params[:gemstone].empty? || !params[:price].empty?)
        @total_products = ShopifyAPI::Product.count
        @total_pages = (@total_products / 250.0).ceil
        products = []
        @total_pages.times do |x|
          page = x+1
          products += ShopifyAPI::Product.find(:all, :params => {:limit => 250, :page => page})
        end
        @count = 0
        @mailer_variant = []
        @metal_blank_product = []
        @mailer_metal = []
        products.each do |product|        
          product.variants.each do |variant|
           if variant.option2 == params_variant

            db_price_value = Variant.where(:metal_title => variant.option1).first.metal_price
            if db_price_value.blank?
              @metal_blank_product << product
              @mailer_variant << variant
              @mailer_metal << variant.option1
            end
              new_price = params_new_price.to_i + db_price_value.to_i
              variant.price = new_price.to_s
              variant.save
              @count = @count + 1 
            end
          end
        end
      end
      ExampleMailer.sample_email(User.first, @mailer_variant, @count, @metal_blank_product, @mailer_metal).deliver
      redirect_to diamond_values_homes_path, notice: 'Variants price was successfully updated.'
    else
      #display only form
    end
  end
  
  def shopify_url
  end

  def update_shopify_url
    url = params[:url]
    Shop.create(:url => url)
    ShopifyAPI::Base.clear_session
    shop_url = Shop.last.url
    ShopifyAPI::Base.site = shop_url
    redirect_to shopify_url_homes_path, notice: 'SHOP URL successfully updated.'
  end
 
end
