class WebhooksController < ApplicationController
	skip_before_filter  :verify_authenticity_token
  before_action :authenticate_user!, :except => [:update_product, :create_product]
  
  def create_product
  	puts "Creating Product"
   	if Product.pluck(:prod_id).exclude? (params[:id])
   		@product = Product.new
 			@product.title = params[:title]
 			@product.prod_id = params[:id]
 			@product.product_type = params[:product_type]
 			params[:options].first.values.each_with_index do |title, index|
     		  @product.metals.build(:name => title.downcase, :price => 0)
    	end           
        
    	respond_to do |format|
      	if @product.save
        	#format.html { redirect_to @product, notice: 'Product was successfully created.' }
        	format.json { render nothing: true, status: :created, location: @product }
      	else
        	#format.html { render :new }
        	format.json { render json: @product.errors, status: :unprocessable_entity }
      	end
      end
    end
  end

  def update_product
   	puts "Updating Product"
   	@product = Product.find_by_prod_id(params[:id])
   	@product.title = params[:title]
 		@product.prod_id = params[:id]
 		@product.product_type = params[:product_type]
 		# params[:options].first.values.each_with_index do |title, index|
   #   		 @product.metals.build(:name => title, :gemstone =>  params[:options].last.values[index] )
   #  end           
    respond_to do |format|
     	if @product.save
        	#format.html { redirect_to @product, notice: 'Product was successfully created.' }
       	format.json { render nothing: true, status: :created, location: @product }
     	else
       	#format.html { render :new }
       	format.json { render json: @product.errors, status: :unprocessable_entity }
     	end
    end
   
  end
end
