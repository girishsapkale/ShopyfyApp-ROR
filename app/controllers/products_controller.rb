class ProductsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create_product]
  before_action :set_product, only: [:edit, :update, :destroy]
  before_action :check_shop, :except => [:set_shop, :update_metals]

  # GET /products
  # GET /products.json
  def index    
    products = Product.all
    if products.blank?
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
      webhooks = ShopifyAPI::Webhook.all
      webhooks.each do |x|
        x.destroy
      end
      update_webhook = ShopifyAPI::Webhook.new({:topic => "products/update", :address => "http://rorapp.mobikasa.com/webhooks/update_product", :format => "json"})
      update_webhook.save!
      create_webhook = ShopifyAPI::Webhook.new({:topic => "products/create", :address => "http://rorapp.mobikasa.com/webhooks/create_product", :format => "json"})
      create_webhook.save!
    end
    @products = Product.includes(:metals)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    
    @product = Product.find(params[:id])
    @api_product = ShopifyAPI::Product.find(@product.prod_id)
       
    metals_list = []

    if @api_product.options.first.name == 'Metal'
        metals = @api_product.options.first.values
        metals.each do |metal_title|
          metals_list << metal_title.downcase
        end           
    end
   
    @metals = metals_list.uniq    
    metals = @product.metals
    if metals.blank?
        @metals.each do |metal_title|
           Metal.create(:name => metal_title, :product_id => @product.id)
        end
    end

    @a = Metal.where(:product_id => @product.id).pluck(:name)
    
    #if @metals & @a == @metals
      old_metal = @a - @metals
      if old_metal.present?
        old_metal.each do |x|             
          @product.metals.find_by_name(x).destroy
        end
      end
    #end

    #unless @metals & @a == @metals
      new_metal = @metals - @a     
      if new_metal.present?
        new_metal.each do |y|          
          @product.metals.build(:name => y, :price => 0).save! 
        end
      end
    #end
    @product = Product.find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    # respond_to do |format|
    #   if @product.save
    #     format.html { redirect_to @product, notice: 'Product was successfully created.' }
    #     format.json { render :show, status: :created, location: @product }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @product.errors, status: :unprocessable_entity }
    #   end
    # end
  end


  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update_metal_prices
    @product = Product.find(params[:id])
    params[:ids].each_with_index do |metal_id, index|
        @variant = @product.metals.find(metal_id)
        @variant.update(:price => params[:prices][index])
    end
      redirect_to @product, notice: 'Product was successfully updated.' 
  end

  def reload_products
    Product.destroy_all

    webhooks = ShopifyAPI::Webhook.all
    webhooks.each do |x|
      x.destroy
    end
   
    redirect_to products_path, notice: 'Product was successfully Reloaded.' 
  end

   
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :product_type, )
    end

    def metal_params
      params.require(:metal).permit(:name, :price)
    end

    def check_shop
      if Shop.first.nil?
        Shop.create(:url => "https://5000b6fab6a48677813d80080e505c18:1eebe1b232ede28bfa0e68c673a317d7@rormobikasa.myshopify.com/admin")
        ShopifyAPI::Base.site = Shop.last.url
      else
        shop_url = Shop.last.url
        ShopifyAPI::Base.site = shop_url
      end
    end
 
end
