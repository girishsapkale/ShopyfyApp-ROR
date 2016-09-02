class HomesController < ApplicationController
  before_action :check_shop, :except => [:set_shop, :update_metals]
  
  def index
    
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
    gemstone_list = Gemstone.all
    @gemstones = gemstone_list.uniq
    if @gemstones.present?
      $alrtb = 0    
    end
    $alrtbb = $alrtbb + 1 if $alrtbb  
  end

  def sync
    Gemstone.delete_all    
    Gemstone.delay.synchronization
    $alrtb = 1
    redirect_to diamond_values_homes_path
  end

  def update_variants_value
    alert = 1
    params[:prices].each { |price| alert = 0 if price.to_i == 0 }
    if alert == 0
      flash[:notice] = "Please set the valid price, not 0"
      redirect_to diamond_values_homes_path
    else
      Variant.delay.update_variants_value(params,current_user.email)
      $alrtbb = 1
      redirect_to diamond_values_homes_path
    end  
  end
  
  def set_shop    
    if Shop.last
      @shop_link_kr = Shop.last.url
    else      
      flash[:notice] = "Please set the correct shop url"
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
 
  def metals_list
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

  def products
    
  end

 private

 def check_shop
  if Shop.first.nil?
    #Shop.create(:url => "https://3c33cb8a597561c457dd429d9ef72fc8:1c2753c8811b76262ccc6aa3f27dda9f@bylu.myshopify.com/admin")
    Shop.create(:url => "https://5000b6fab6a48677813d80080e505c18:1eebe1b232ede28bfa0e68c673a317d7@rormobikasa.myshopify.com/admin")
    ShopifyAPI::Base.site = Shop.last.url
  else
    shop_url = Shop.last.url
    ShopifyAPI::Base.site = shop_url
  end
 end
 
end
