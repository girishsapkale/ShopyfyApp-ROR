class HomesController < ApplicationController
  before_action :set_product, only: [:show, :destroy]

  # GET /homes
  # GET /homes.json
  def index
    @products = ShopifyAPI::Product.all
    variants = Variant.all
    metals_list = []
    @products.each do |product|
      if product.options.first.name == 'Metal'

          metals = product.options.first.values
          metals.each do |metal_title|
          metals_list << metal_title
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
    
    @users = User.all

  end

  def show
  end

  def new
   
  end

  def edit
    @home = Home.find(params[:id])
  end

  def edit_order
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


  def update_metals
    count = params[:ids].count
    count.times do |x|
      @metal = Variant.find(params[:ids][x])
      @metal.update_attributes(:metal_price => params[:metal_prices][x])
    end
    redirect_to root_path, notice: 'Metal updated.' 
  end

  private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
       params[:home]
    end
end
