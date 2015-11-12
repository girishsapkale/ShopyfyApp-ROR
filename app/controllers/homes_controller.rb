class HomesController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /homes
  # GET /homes.json
  def index
    #@products = ShopifyAPI::Product.all
    #@orders = ShopifyAPI::Order.all
    @users = User.all
    puts"+++++++++++++++++++++++++++#{@users.first.inspect}"
  end

  def show
  end

  def new
   
  end

  def edit
  end

  def edit_order
  end

  def create_product        
    new_product = ShopifyAPI::Product.new
    new_product.title = params[:title]
    new_product.product_type = params[:product_type]
    new_product.vendor = params[:vendor]
    
    respond_to do |format|
      if new_product.save
        format.html { redirect_to root_path, notice: 'Home was successfully created.' }
        format.json { render :show, status: :created, location: @home }
      else
        format.html { render :new }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1
  # PATCH/PUT /homes/1.json
  def update_product
    @product = ShopifyAPI::Product.find(params[:id])
    respond_to do |format|
      if @product.update_attributes(:title => params[:title], :product_type => params[:product_type], :vendor => params[:vendor] )
        format.html { redirect_to root_path, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @home }
      else
        format.html { render :edit }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to homes_url, notice: 'Home was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_order
    
  end

  def create_order

    products = ShopifyAPI::Product.all
    product = products.last

    new_order = ShopifyAPI::Order.new(
     :email => params[:email],
     :first_name => params[:first_name],
     :last_name => params[:last_name],
     :line_items => [ShopifyAPI::LineItem.new(:variant_id => product.variants.last.id, :quantity => 3),ShopifyAPI::LineItem.new(:variant_id => product.variants.last.id, :quantity => 2),ShopifyAPI::LineItem.new(:variant_id => product.variants.last.id, :quantity => 1)]
    )
   
    respond_to do |format|
      if new_order.save
        format.html { redirect_to root_path, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

    def update_order
    @order = ShopifyAPI::Order.find(params[:id])

    products = ShopifyAPI::Product.all
    product = products.last

    respond_to do |format|
      if @order.update_attributes(:email => params[:email], :first_name => params[:first_name], :last_name => params[:last_name],:line_items => [:variant_id => product.variants.last.id, :quantity => params[:quantity]])
        byebug
        format.html { redirect_to root_path, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @home }
      else
        format.html { render :edit }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = ShopifyAPI::Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
       params[:home]
    end
end
