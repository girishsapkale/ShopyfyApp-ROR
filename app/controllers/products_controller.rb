class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :check_shop, :except => [:set_shop, :update_metals]
  # GET /products
  # GET /products.json
  def index
    @total_products = ShopifyAPI::Product.count
    @total_pages = (@total_products / 250.0).ceil
    @products = []
    @total_pages.times do |x|
      page = x+1
      @products += ShopifyAPI::Product.find(:all, :params => {:limit => 250, :page => page})
    end
    products = Product.all

    if products.blank?
      @products.each do |product|
        if product.options.first.name == 'Metal'
            element = Product.new
            element.title = product.title
            element.product_type = product.product_type
            element.prod_id = product.id
            product.options.first.values.each_with_index do |title, index|
              element.metals.build(:name => title, :gemstone =>  product.options.last.values[index] )
            end           
            element.save!
        end      
      end
    end
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
   
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
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
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
