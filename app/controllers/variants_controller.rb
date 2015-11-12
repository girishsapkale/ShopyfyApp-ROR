class VariantsController < ApplicationController
  before_action :set_variant, only: [:show, :destroy]

  # GET /variants
  # GET /variants.json
  def index
    products = ShopifyAPI::Product.all
    @products = []
    products.each do |product|
      if product.options
        product.options.each do |varient|
          if varient.name == 'Diamond'
            @products << product
          end  
        end        
      end
    end
  end

  # GET /variants/1
  # GET /variants/1.json
  def show
  end

  # GET /variants/new
  def new
    @variant = Variant.new
  end

  # GET /variants/1/edit
  def edit
    @product = ShopifyAPI::Product.find(params[:id])
  end

  # POST /variants
  # POST /variants.json
  def create
    @variant = Variant.new(variant_params)

    respond_to do |format|
      if @variant.save
        format.html { redirect_to @variant, notice: 'Variant was successfully created.' }
        format.json { render :show, status: :created, location: @variant }
      else
        format.html { render :new }
        format.json { render json: @variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /variants/1
  # PATCH/PUT /variants/1.json
  def update
    @product = ShopifyAPI::Product.find(params[:id])
    @product.variants.each do |variant|
      variant.option2 = params["updated_price_of_diamond_#{variant.id}"]
      variant.save  
    end
    
    respond_to do |format|
      #if @variant.update(variant_params)
        format.html { redirect_to variants_url, notice: 'Variants was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @variant }
      #else
      #  format.html { render :edit }
      #  format.json { render json: @variant.errors, status: :unprocessable_entity }
      #end
    end
  end

  # DELETE /variants/1
  # DELETE /variants/1.json
  def destroy
    @variant.destroy
    respond_to do |format|
      format.html { redirect_to variants_url, notice: 'Variant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_variant
      @variant = Variant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def variant_params
      params[:variant]
    end
end
