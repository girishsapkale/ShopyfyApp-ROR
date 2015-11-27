class WebhooksController < ApplicationController
	skip_before_filter  :verify_authenticity_token
  before_action :authenticate_user!, :except => [:update_product, :create_product]
  
  def create_product
  	puts "Creating Product"
   	if Product.pluck(:prod_id).exclude? (params[:id])
      if params[:options].first.values[2] == 'Metal'
   		    @product = Product.new
 			    @product.title = params[:title]
 			    @product.prod_id = params[:id]
 			    @product.product_type = params[:product_type] 			             
          @product.save      	
      end
    end
    respond_to do |format|          
            format.json { render nothing: true, status: :created, location: @product }         
    end
  end

  def update_product
   	puts "Updating Product"    
    if Product.find_by_prod_id(params[:id]).blank?
      if params[:options].first.values[2] == 'Metal'
          @product = Product.new
          @product.title = params[:title]
          @product.prod_id = params[:id]
          @product.product_type = params[:product_type]                    
          @product.save       
      end
    end    
   	@product = Product.find_by_prod_id(params[:id])
   	@product.title = params[:title]
 		@product.prod_id = params[:id]
 		@product.product_type = params[:product_type]
    @product.save 	         
    respond_to do |format|     
       	format.json { render nothing: true, status: :created, location: @product } 
    end
   
  end
end
