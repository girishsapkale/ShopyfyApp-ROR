class WebhooksController < ApplicationController
	skip_before_filter  :verify_authenticity_token
  before_action :authenticate_user!, :except => [:update_product, :create_product, :delete_product]
  
  def create_product
  	puts "Creating Product"
   	if Product.pluck(:prod_id).exclude? (params[:id])
      if params[:options].first.values[2] == 'Metal'
          @product = Product.find_by_prod_id(params[:id])
          if !@product.present?
   		      @product = Product.new
 			      @product.title = params[:title]
 			      @product.prod_id = params[:id]
 			      @product.product_type = params[:product_type] 			             
            @product.save
          end        	
      end
    end
    render json: {message: "OK", status: true}, status: 200
    # respond_to do |format|          
    #   format.json { render message: 'OK', status: true, status: 200 }
    #   #render json: {message: 'User log out!', status: true}, status: 200         
    # end
  end

  def update_product
   	puts "Updating Product"    
    if Product.find_by_prod_id(params[:id]).blank?
      if params[:options].first.values[2] == 'Metal'
        @product = Product.find_by_prod_id(params[:id])
        if !@product.present?
          @product = Product.new
          @product.title = params[:title]
          @product.prod_id = params[:id]
          @product.product_type = params[:product_type]                    
          @product.save
        end         
      end
    end    
   	@product = Product.find_by_prod_id(params[:id])
    if @product.present?
   	  @product.title = params[:title]
 		  @product.prod_id = params[:id]
 		  @product.product_type = params[:product_type]
      @product.save
    end
    render json: {message: "OK", status: true}, status: 200   	         
    # respond_to do |format|     
    #   #format.json { render nothing: true, status: :created, location: @product }
    #   format.json { render message: 'OK', status: true, status: 200 } 
    # end   
  end

  def delete_product
    @product = Product.find_by_prod_id(params[:id])
    if @product.present? 
      @product.destroy
    end  
    render json: {message: "OK", status: true}, status: 200
    #respond_to do |format|      
      #format.json { render message: 'OK', status: true, status: 200 }       
    #end
  end
end
