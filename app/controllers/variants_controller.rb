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

  def update_variants
    if request.put?
      @params_query = params[:query]
      products = ShopifyAPI::Product.all
      @productss = products      
    else
      #display only form
    end
  end

  def update_variants_value
    if request.put?      
      params_variant = params[:query_1]
      params_new_price = params[:query_2]
      if( !params[:query_1].empty? || !params[:query_2].empty?)
        products = ShopifyAPI::Product.all
        count = 0
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
              count = count + 1 
            end
          end
        end
      end
      #@productss = products      
      flash[:notice] = " #{count} Variants price was successfully updated."

      # Sends email to user when user is created.
      ExampleMailer.sample_email(User.first, @mailer_variant, count, @metal_blank_product, @mailer_metal).deliver

    else
      #display only form
    end
  end

  def variants_update
    notice = 'please try again!'
    params.each do |layer_number, params|      
      if layer_number.include? "updated_price_of_variant_"
        result = layer_number.gsub(/\D/, '')
                
        variant = ShopifyAPI::Variant.find(result)
        
        updated_price = params["#{layer_number}"]
        
        updated_price = variant.price.to_i + params.to_i
        
        variant.price = updated_price.to_s
        variant.save
        notice = 'Variants price was successfully updated.'       
      end
    end
    respond_to do |format|
      format.html { redirect_to update_variants_path, notice: notice }      
    end    
  end

  def variants_update_title
    notice = 'please try again!'
    params.each do |layer_number, params|      
      if layer_number.include? "updated_price_of_variant_"
        result = layer_number.gsub(/\D/, '')
                
        variant = ShopifyAPI::Variant.find(result)
        
        updated_price = params["#{layer_number}"]
        
        updated_price = variant.price.to_i + params.to_i
        
        variant.price = updated_price.to_s
        variant.save
        notice = 'Variants price was successfully updated.'       
      end
    end
    respond_to do |format|
      format.html { redirect_to update_variants_path, notice: notice }      
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
      #params[:variant]
      params.require(:variant).permit(:k14_white_recycled_price, :k14_yellow_recycled_price,
       :k14_rose_recycled_price, :k18_white_recycled_price, :k18_rose_recycled_price, :platinum_recycled_price,
       :k18_yellow_recycled_price)
    end

    def check_price(value)
      if value == '14k white (recycled)'
        Variant.first.k14_white_recycled_price
      elsif value == '14k yellow (recycled)'
        Variant.first.k14_yellow_recycled_price
      elsif value == '14k rose (recycled)'
        Variant.first.k14_rose_recycled_price
      elsif value == '18k white (recycled)'
        Variant.first.k18_white_recycled_price
      elsif value == '18k yellow (recycled)'
        Variant.first.k18_yellow_recycled_price
      elsif value == '18k rose (recycled)'
        Variant.first.k18_rose_recycled_price
      elsif value == 'Platinum (recycled)'
        Variant.first.platinum_recycled_price        
      else
        1
      end 
          
    end
end